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

  # GET /decks/new
  # GET /decks/new.json
  def new
    @current_deck = Deck.new
  end

  # POST /decks
  # Create a new deck 
  def create
    @current_deck = Deck.new(params[:deck])
    respond_to do |format|
      if @current_deck.save
        format.html { redirect_to decks_url, notice: "Deck Created: #{@current_deck.name}" }
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
        format.html { redirect_to root_path, notice: 'Deck Name Updated!' }
      else
        format.html { render action: "update" }
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
        format.html { redirect_to "/decks/#{params[:deck_id]}/play/#{params[:time_id_old]}", notice: "Wrong" }
        format.json { head :no_content }
      end

    end

  end
  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to decks_path }
      format.json { head :no_content }
    end
  end
end
