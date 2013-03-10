class DecksController < ApplicationController
  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @decks }
    end
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
    @current_deck = Deck.find(params[:id])
    @new_card = Card.new
    @cards_in_deck = @current_deck.cards
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deck }
    end
  end

  # GET /decks/new
  # GET /decks/new.json
  def new
    @deck = Deck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deck }
    end
  end

  # GET /decks/1/edit
  def edit
    @deck = Deck.find(params[:id])
  end

  # POST /decks
  # POST /decks.json
  def create
    @deck = Deck.new(params[:deck])
    respond_to do |format|
      if @deck.save
        format.html { redirect_to @deck, notice: 'Deck was successfully created.' }
        format.json { render json: @deck, status: :created, location: @deck }
      else
        format.html { render action: "new" }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

   
  # update deck with created card for current deck
  def create_card 
    @deck = Deck.find(params[:deck_id])
    respond_to do |format|
      if @deck.cards.create(params[:deck][:card])
        format.html { redirect_to @deck, notice: "Card was successfully added to Deck #{@deck.name}." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # play the deck first using the deck time to get the first card
  # get the next card if it is not the same as the other card
  def play_deck
    @current_deck = Deck.find(params[:deck_id])
    @deck_time = @current_deck.time
    @past_card_time = params[:time_id]

    if (@past_card_time.to_i == @deck_time)
      @text = 'deck_time' 

      if (@current_card = @current_deck.cards.first).nil?
        respond_to do |format|
          format.html { redirect_to decks_path, notice: 'Deck does not have any cards'}
          format.json { head :no_content }
        end
      end


    else 
      @text = 'card_time'
      #get the next card based on the next biggest card time.
      if (@current_card = @current_deck.cards.where(:time.gt => @past_card_time).first).nil?
        #if there are no more cards redirect to decks indexs and display message
           respond_to do |format|
             format.html { redirect_to decks_path, notice: 'You have completed the deck'}
             format.json { head :no_content }
            end
        end
    end


  end

  # check if the two stirngs are equal
  # in the future can expand check by using regexp
  def check_answer
    @current_deck = Deck.find(params[:deck_id])
    @current_card = @current_deck.cards.find_by(time: params[:time_id])
   
    # if answer submitted answer is correct
    if @current_card.answer == params[:answer][:answer] 
      respond_to do |format|
        format.html { redirect_to "/decks/#{params[:deck_id]}/play/#{params[:time_id]}" }
        format.json { head :no_content }
      end

    # if answer submitted answer is wrong 
    else
      respond_to do |format|
        format.html { redirect_to "/decks/#{params[:deck_id]}/play/#{params[:time_id_old]}" }
        format.json { head :no_content }
      end

    end

  end
  # DELETE /decks/1
  # DELETE /decks/1.json
  def remove_deck 
    @deck = Deck.find(params[:deck_id])
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to decks_url }
      format.json { head :no_content }
    end
  end
end
