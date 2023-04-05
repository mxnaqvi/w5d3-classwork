require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
include Singleton
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
    attr_accessor :id, :fname, :lname
    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def self.find_by_id(target)
        user = QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?;
        SQL
        User.new(user.first)
    end

    def self.find_by_name(fname_target, lname_target)
        user = QuestionsDatabase.instance.execute(<<-SQL, fname_target, lname_target)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? AND lname = ?;
        SQL
        User.new(user.first)
    end

    def authored_questions
        Question.find_by_associated_author(self.id)
    end

    def authored_replies
        Reply.find_by_user_id(self.id)
    end
end

class Question
    attr_accessor :id, :title, :body, :associated_author

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @associated_author = options['associated_author']
    end

    def self.find_by_id(target)
        question = QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?;
        SQL
        Question.new(question.first)
    end

    def self.find_by_associated_author(target)
        question = QuestionsDatabase.instance.execute(<<-SQL, target)
        SELECT
            *
        FROM
            questions
        WHERE
            associated_author = ?;
        SQL
        Question.new(question.first)
    end

    def author  
        User.find_by_id(self.associated_author)
    end

    def replies
        Reply.find_by_question_id(self.id)
    end
end

class QuestionFollow
    attr_accessor :ord, :question_id, :users_id
    def initialize(options)
        @ord = options['ord']
        @question_id = options['question_id']
        @users_id = options['users_id']
    end

    def self.find_by_id(target)
        questionfollow = QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                question_follows
            WHERE
                ord = ?;
        SQL
        QuestionFollow.new(questionfollow.first)
    end
end

class Reply
    attr_accessor :seq_id, :users_id, :question_id, :replies_id
    def initialize(options)
        @seq_id = options['seq_id']
        @question_id = options['question_id']
        @users_id = options['users_id']
        @replies_id = options['replies_id']
    end

    def self.find_by_id(target)
        reply = QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                replies
            WHERE
                seq_id = ?;
        SQL
        Reply.new(reply.first)
    end

    
    def self.find_by_user_id(target)
        reply = QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                replies
            WHERE
                users_id = ?;
        SQL
        Reply.new(reply.first)
    end

    def self.find_by_question_id(target)
        reply = QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id = ?;
        SQL
        Reply.new(reply.first)
    end

    def parent_reply
      if self.replies_id.nil?
        raise 'no parent' 
      end
        Reply.find_by_id(self.replies_id)
    end

    def child_reply
        if !self.replies_id.nil?
            raise_error 'no child'
        end
        target = self.seq_id
       reply =  QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                replies
            WHERE
                replies_id = ?;
        SQL
     if reply.nil?
        raise_error 'no child'
     end
         Reply.new(reply.first)
    end
end

class QuestionLike
    attr_accessor :id, :liked, :users_id, :questions_id
    def initialize 
        @id = options['id']
        @liked = options['liked']
        @users_id = options['users_id']
        @questions_id = options['question_id']
    end

    def self.find_by_id(target)
        questionlike = QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?;
        SQL
        QuestionLike.new(questionlike.first)
    end
end

