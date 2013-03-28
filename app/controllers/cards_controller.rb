class CardsController < ApplicationController
  # Require user to be logged in
  before_filter :authenticate_user!

  # GET /cards/new
  # GET /cards/new.json
  # Create a new card in the deck
  def new
    @current_deck = Deck.find(params[:deck_id])
    @card_list = @current_deck.cards
    @current_card = Card.new
  end

  # POST /cards
  # POST /cards.json
  def create
    @current_deck = Deck.find(params[:deck_id])

    respond_to do |format|
      if @current_deck.cards.create(params[:card])
        format.html { redirect_to new_deck_card_path(@current_deck), notice: "Card Created" }
      else
        format.html { render :new }
        format.json { render json: @current_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /cards/1/edit
  def edit
    @current_deck = Deck.find(params[:deck_id])
    @current_card = @current_deck.cards.find(params[:id])
    @past_view = params[:view]
    @past_card_id = params[:past_card_id]
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @current_deck = Deck.find(params[:deck_id])
    @current_card = @current_deck.cards.find(params[:id])

    respond_to do |format|
      if @current_card.update_attributes(params[:card])

        # determine where to redirect to the play area or the create cards area
        if params[:addon][:past_view] == "play" 
          format.html { redirect_to deck_card_game_play_path(@current_deck,params[:addon][:past_card_id]), notice: 'Card Updated' }
        else
          format.html { redirect_to new_deck_card_path(@current_deck), notice: 'Card Updated' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  def destroy 
    @current_deck = Deck.find(params[:deck_id])
    @current_card = @current_deck.cards.find(params[:id])
    @current_card.destroy
    
    respond_to do |format|
      format.html { redirect_to new_deck_card_path(@current_deck)  }
      format.json { head :no_content }
    end
  end
end
