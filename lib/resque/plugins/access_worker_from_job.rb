module Resque
  module Plugins
    # Adds a Resque plugin to allow jobs to access the worker running them as the last argument in the call
    # to +perform+.  Purpose: this allows jobs to access shared sockets in the parent worker.
    #
    # Be careful to note that each job forks before running, however, so ivars will be a COPY and, if changed,
    # their changes won't persist into the next job's perform method.  However, since sockets ARE persisted, this
    # allows multiple jobs to share a single persistent socket kept alive in the worker.
    #
    # As additional functionality, this plugin can also abort a job gracefully if it's picked up by the wrong worker 
    # class, which is useful if you've subclassed Resque::Worker to add your own functionality and need to ensure
    # your jobs aren't accidentally run against the original superclass.
    #
    # To use, add 
    #
    #   extend Resque::Plugins::AccessWorkerFromJob
    #
    # to the class with the perform method.
    # 
    # To implement the additional requiring-certain-worker-class feature, add 
    #
    #   self.required_worker_class = 'ClassName'
    #
    # as well.
    module AccessWorkerFromJob
      attr_accessor :required_worker_class
      
      # Overrides args to append the worker when returning the list of args represented in this job's payload.
      def args
        @payload['args'] + [worker]
      end
      
      # Abort gracefully if picked up by the wrong worker, so message remains in queue to be sent
      def before_perform_ensure_proper_worker(*args)
        worker = args.last
        if required_worker_class && worker.class.name != required_worker_class
          raise ::Resque::Job::DontPerform
        end

        # TODO: Make sure this keeps the job in the queue! seems to just skip it and remove from queue, so it'll never be performed
        # raise ::Resque::Job::DontPerform
      end
      
    end
  end
end