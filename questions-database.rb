require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
include 'Singleton'
  def intialize
    super (questions.db)
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Users
    attr_accessor :id, :fname, :lname
    def intialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
end

class Questions 
    attr_accessor :id, :title, :body, :associated_author
    def intialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @associated_author = options['associated_author']
    end
end

class QuestionFollows
    attr_accessor :id, :questions_id, :users_id
    def intialize(options)
        @id = options['id']
        @questions_id = options['questions_id']
        @users_id = options['users_id']
    end
end

class Replies
    attr_accessor :id, :users_id, :questions_id, :replies_id
    def intialize
        @id = options['id']
        @questions_id = options['questions_id']
        @users_id = options['users_id']
        @replies_id = options['replies_id']
    end
end

class QuestionLikes
    attr_accessor :liked, :users_id, :questions_id
    def intialize 
        @liked = options['liked']
        @users_id = options['users_id']
        @questions_id = options['question_id']
    end
end