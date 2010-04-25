module Resque # :nodoc:
  # Resque-AccessWorkerFromJob plugin overrides the Resque::Job#args method to pass the worker along as the last argument.
  class Job
    # Overridden args appends the worker when returning the list of args represented in this job's payload.
    def args
      @payload['args'] + [worker]
    end
    
  end
end
