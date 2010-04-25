module Resque  
  module Plugins # :nodoc:
    # Adds a Resque plugin to allow jobs to access the worker running them via a cleverly-named +worker+ 
    # instance variable.  Purpose: this allows jobs to access shared sockets in the parent worker.
    #
    # Be careful to note that each job forks before running, however, so instance variables will be a COPY and, if 
    # changed, their changes won't persist into the next job's perform method.  However, since sockets ARE persisted,
    # this allows multiple jobs to share a single persistent socket kept alive in the worker.
    #
    # To use, add 
    #
    #   extend Resque::Plugins::AccessWorkerFromJob
    #
    # to the BOTTOM of the class with the perform method (the extend line must come AFTER the perform method has 
    # already been defined, or else the alias method will fail). Now your perform method can reference a +worker+
    # attribute.
    # 
    # As additional functionality, this plugin can also abort a job gracefully if it's picked up by the wrong worker 
    # class, which is useful if you've subclassed Resque::Worker to add your own functionality and need to ensure
    # your jobs aren't accidentally run against the original superclass.  Note that if your job is picked up by the
    # wrong class it'll be removed from the queue, though -- this provides a way to avoid messy exceptions, but it's
    # still your responsibility to make sure you keep your queues + worker classes straight.
    #
    # To implement this additional requiring-certain-worker-class feature, add 
    #
    #   self.required_worker_class = 'ClassName'
    #
    # as well.
    module AccessWorkerFromJob
      attr_accessor :required_worker_class, :worker
      
      def self.extended(base)
        
        unless base.methods.include?('perform')
          raise %Q{You must call "extend Resque::Plugins::AccessWorkerFromJob" AFTER (below) defining the perform method}
        end
        
        class << base
          
          # Remove worker from last argument, so can write their perform method assuming just the arguments
          # they sent it, without worrying about the appended worker.
          def perform_with_worker_in_arguments(*args)
            args.pop if args.last.is_a?(::Resque::Worker)
            perform_without_modified_arguments( *args )
          end

          alias_method :perform_without_modified_arguments, :perform unless method_defined?(:perform_without_modified_arguments)
          alias_method :perform, :perform_with_worker_in_arguments
        end 
      end
      
      
      # Abort gracefully if picked up by the wrong worker (job will be removed from queue)
      def before_perform_ensure_proper_worker(*args)
        if args.last.is_a?(::Resque::Worker)
          self.worker = args.last
        else
          raise "You must override Resque::Job#args to pass worker as last argument. See README."
        end
        
        if required_worker_class && worker.class.name != required_worker_class
          raise ::Resque::Job::DontPerform
        end
      end
      
    end
  end
end
