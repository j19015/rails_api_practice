class UsersController < ApplicationController
    def index
        #登録されているユーザの情報を全取得
        users=User.all
        #取得したユーザのデータをjson形式で返す
        render json: {data: users}
    end

    def create
        #User型の新しいインスタンスを作成
        user=User.new(user_params)
        if user.save
            #json形式でuserの情報を返す & HTTPのステータスレコードでcreated(201)を返す。（作成が上手くできたよってことで大丈夫そう）
            render json: user, status: :created
        else
            #json形式でuserの格納されているエラーを返す & HTTPレコードで unprocessable Entity(422)を返す。(要求本文の構文が正しいが、中に含まれている指示が処理できなかった場合を示す)
            render json: user.errors, status: :unprocessable_entity
        end
    end

    private

    def user_params
        #nameを取得
        params.permit(:name)
    end
end
