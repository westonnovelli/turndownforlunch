class SuggestionsController < ApplicationController
    before_action :set_suggestion, only: [:show, :edit, :update, :destroy, :vote_up, :vote_down]

    def index
      @suggestions = Suggestion.all
      @up_votes_for_user = []
      @suggestion_votes = Hash.new {|h, k| h[k] = []}
      Vote.all.each do |vote|
        if current_user
          @up_votes_for_user << vote.suggestion_id if vote.user_id == current_user.id
        end
        @suggestion_votes[vote.suggestion_id] << Users.find(vote.user_id)
      end
      @suggestions.each do |suggestion|
        puts "#{suggestion.location} #{@suggestion_votes[suggestion.id]}"
      end
    end

    def show
    end

    def new
      @suggestion = Suggestion.new
    end

    def edit
    end

    def create
      logger.info "creating suggestion"
      @suggestion = Suggestion.new(suggestion_params)
      @suggestion.createSuggestion
      @suggestion.reload

      respond_to do |format|
        if @suggestion.save
          format.html { redirect_to suggestions_url, notice: 'Suggestion was successfully created!' }
          format.json { render action: 'show', status: created, location: @suggestion }
        else
          format.html { render action: 'new' }
          format.json { render json: @suggestion.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @suggestion.update(suggestion_params)
          format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated!' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @suggestion.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @suggestion.destroy
      respond_to do |format|
        format.html { redirect_to suggestions_url }
        format.json { head :no_content }
      end
    end

    def vote_up
      success, message = current_user.up_vote(@suggestion)
      if success
        respond_to do |format|
          flash[:notice] = message
          format.html { redirect_to suggestions_url }
        end
      else
        logger.info "you have already voted for this"
        respond_to do |format|
          format.html {
            flash[:warn] = message
            redirect_to suggestions_url
          }
        end
      end
    end

    def vote_down
      vote = Vote.where(:suggestion_id => @suggestion.id, :user_id => current_user.id)
      unless vote.nil?
        @suggestion.vote_down
        Vote.destroy(vote[0].id)
      end
      respond_to do |format|
        format.html {
          flash[:notice] = "Your vote has been removed."
          redirect_to suggestions_url
        }
      end

    end

    private
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    private
    def set_user
      @user = User.find(params[:user_id])
    end

    def suggestion_params
      params.require(:suggestion).permit(:location, :departure_time)
    end
end
