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
        # raise 'id doesn\'t exist' unless self.id
        user = QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?;
        SQL
        User.new(user)
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
        # raise 'id doesn\'t exist' unless self.id
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
end

class QuestionFollow
    attr_accessor :id, :questions_id, :users_id
    def initialize(options)
        @id = options['id']
        @questions_id = options['questions_id']
        @users_id = options['users_id']
    end

    def self.find_by_id(target)
        questionfollow = QuestionsDatabase.instance.execute(<<-SQL, target)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?;
        SQL
        QuestionFollow.new(questionfollow.first)
    end
end

class Reply
    attr_accessor :id, :users_id, :questions_id, :replies_id
    def initialize(options)
        @id = options['id']
        @questions_id = options['questions_id']
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
                id = ?;
        SQL
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

