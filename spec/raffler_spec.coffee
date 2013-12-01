describe "Raffler", ->

	test = {}

	it "should be defined", ->
		expect(Raffler).toBeDefined()

	#-------------------------------------------------------------------------------
	describe "Raffler Routers Entries", ->
		it "should be defined", ->
			expect(Raffler.Routers.Entries).toBeDefined()

	#-------------------------------------------------------------------------------
	describe "Raffler Views EntriesIndex", ->

		test.collection_data = [
			{ id:1, name:'Tony', winner:false },
			{ id:2, name:'Steve', winner:false },
			{ id:3, name:'Mike', winner:false },
			{ id:4, name:'Moe', winner:false }
		]

		test.element = document.createElement 'div'

		beforeEach ->
			test.collection = new Raffler.Collections.Entries test.collection_data
			test.view = new Raffler.Views.EntriesIndex
				collection: test.collection
				el: test.element
			test.view.render

		it "should be defined", ->
			expect(Raffler.Views.EntriesIndex).toBeDefined()

		it "should use the specified element", ->
			expect(test.view.el).toEqual test.element

		it "should use the specified collection", ->
			expect(test.view.collection).toEqual test.collection

		it "should render collection items into the UL element in its template", ->
			test.view.render()
			expect($(test.element).find('li').length).toEqual 4

		it "should render when an element is added to the collection", ->
			test.collection.add
				id:5
				name:'Larry'
				winner:false
			expect($(test.element).find('li').length).toEqual 5

		it "should render when an element is destroyed", ->
			entry = test.collection.get(1)
			entry.destroy()
			expect($(test.element).find('li').length).toEqual 3

		it "should destroy an entry when its li element is clicked", ->
			li = $(test.element).find('li')[2]; #Mike
			removed_entry = test.collection.get li.id
			before_length = test.collection.length
			$(li).trigger 'click'
			expect(test.collection.length).toEqual before_length-1
			expect(test.collection.models).not.toContain removed_entry


	#-------------------------------------------------------------------------------
	describe "Raffler Model Entry", ->

		it "should be defined", ->
			expect(Raffler.Models.Entry).toBeDefined()

		describe "Validations", ->

			attrs = {}

			beforeEach ->
				attrs =
					name: 'Tony'
					winner: false

			afterEach ->
				test.raffler = new Raffler.Models.Entry attrs
				expect(test.raffler.isValid()).toBeFalsy()

			it "should validate that name is a string", ->
				attrs['name'] = ['array']

			it "should validate the presence of name", ->
				attrs['name'] = ''


	#-------------------------------------------------------------------------------
	describe "Raffler Collections Entries", ->

		it "should be defined", ->
			expect(Raffler.Collections.Entries).toBeDefined()

		it "should use the Raffler.Models.Entry model", ->
			test.entries = new Raffler.Collections.Entries
			expect(test.entries.model).toEqual Raffler.Models.Entry















