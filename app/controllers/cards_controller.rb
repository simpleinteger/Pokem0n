class CardsController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @current_deck = Deck.find(params[:deck_id])
    @card_in_deck = @current_deck.cards.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card_in_deck }
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def delete_card 
    @current_deck = Deck.find(params[:deck_id])
    @card_in_deck = @current_deck.cards.find(params[:id])
    @card_in_deck.destroy

    respond_to do |format|
      format.html { redirect_to @current_deck }
      format.json { head :no_content }
    end
  end
end
