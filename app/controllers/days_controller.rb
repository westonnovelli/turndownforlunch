class DaysController < ApplicationController
  before_action :set_day, only: [:show, :edit, :update, :destroy, :prev, :next]

  def prev
    session[:return_to] ||= request.referer
    @day = @day.prev
    session[:day_id] = @day.id
    referer = session.delete(:return_to)
    if referer.nil? and referer != request.original_url
      redirect_to suggestions_url
    else
      redirect_to referer
    end
  end

  def next
    session[:return_to] ||= request.referer
    @day = @day.next
    session[:day_id] = @day.id
    referer = session.delete(:return_to)
    if referer.nil? and referer != request.original_url
      redirect_to suggestions_url
    else
      redirect_to referer
    end
  end

  def today
    session[:return_to] ||= request.referer
    @day = Day.get_or_create(Date.today)
    session[:day_id] = @day.id
    DaysController.sync(@day.date)
    referer = session.delete(:return_to)
    if referer.nil? and referer != request.original_url
      redirect_to suggestions_url
    else
      redirect_to referer
    end
  end

  def goto
    session[:return_to] ||= request.referer
    @day = Day.get_or_create(Date.parse(params[:goto_day]))
    session[:day_id] = @day.id
    referer = session.delete(:return_to)
    if referer.nil? and referer != request.original_url
      redirect_to suggestions_url
    else
      redirect_to referer
    end
  end

  # GET /days
  # GET /days.json
  def index
    @days = Day.all
  end

  # GET /days/1
  # GET /days/1.json
  def show
  end

  # GET /days/new
  def new
    @day = Day.new
  end

  # GET /days/1/edit
  def edit
  end

  # POST /days
  # POST /days.json
  def create
    @day = Day.new(day_params)
    respond_to do |format|
      if @day.save
        format.html { redirect_to @day, notice: 'Day was successfully created.' }
        format.json { render action: 'show', status: :created, location: @day }
      else
        format.html { render action: 'new' }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /days/1
  # PATCH/PUT /days/1.json
  def update
    respond_to do |format|
      if @day.update(day_params)
        format.html { redirect_to @day, notice: 'Day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /days/1
  # DELETE /days/1.json
  def destroy
    @day.destroy
    respond_to do |format|
      format.html { redirect_to days_url }
      format.json { head :no_content }
    end
  end

  def self.sync(date)
    logger.info "Syncing db"
    # removes days older than two weeks ago, and sets the winners of the last 14 days of suggestions
    # removes suggestions from those days older than two weeks ago too
    Day.where("date < ?", date).each do |day|
      if (day.date + 14) < date
        Day.destroy(day.id)
      else
        max = 0
        leader = []
        Suggestion.where("day_id == #{day.id}").each do |suggestion|
          suggestion_day = Day.find(suggestion.day_id)
          if suggestion_day.nil? or suggestion_day.date < (date - 14)
            Suggestion.destroy(suggestion.id)
            continue
          end
          if suggestion.winner == 1
            leader = []
            break
          end
          if suggestion.votes >= max
            max = suggestion.votes
            leader << suggestion
          end
        end
        unless leader.empty?
          leader.each do |suggestion|
            suggestion.winner = 1
            suggestion.save
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day
      @day = Day.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_params
      params.require(:day).permit(:date)
    end
end
