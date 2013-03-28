class DecksController < ApplicationController
  # Require user to be logged in
  before_filter :authenticate_user!

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @decks }
    end
  end

  # GET /decks/new
  # GET /decks/new.json
  def new
    @current_deck = Deck.new
  end

  # POST /decks
  # Create a new deck 
  def create
    @current_user = User.find(current_user.id)
    @current_deck = @current_user.decks.new(params[:deck])
    respond_to do |format|
      if @current_deck.save
        format.html { redirect_to user_root_path, notice: "Deck Created: #{@current_deck.name}" }
      else
        format.html { render :new }
        format.json { render json: @current_deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /decks/:id/edit
  # View the edit page
  # form in here links to the update method route 
  def edit
    @current_deck = Deck.find(params[:id])
  end

  # PUT /decks/:id
  # update the deck name
  # redirects to index page 
  def update
    @current_deck = Deck.find(params[:id])

    respond_to do |format|
      if @current_deck.update_attribute(:name, params[:deck][:name])
        format.html { redirect_to user_root_path, notice: 'Deck Name Updated!' }
      else
        format.html { render action: "update" }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to user_root_path }
      format.json { head :no_content }
    end
  end
end
