gabe = User.new(name:'gabriel d', username: 'gabed', password: '123456', id: 1)
dayne = User.new(name: 'dayne d', username: 'dayned', password: '654321', id: 2 )

happy= Word.new(word: 'happy', definition: 'to be happy', id: 1)
glad = Word.new(word: 'glad', definition: 'to be glad', id: 2)
sad = Word.new(word: 'sad', definition: 'to be sad', id: 3)
upset = Word.new(word: 'upset', definition: 'to be upset', id: 4)

happylist = Vocablist.new(name: 'happy list', id: 1)
sadlist = Vocablist.new(name: 'sad list', id: 2)


gabesvocab = UserList.new(user_id: 1, vocablist_id: 1, id: 1)
daynesvocab = UserList.new(user_id: 2, vocablist_id: 2, id: 2)

happyglad = SimilarWord.new(word_id: 1, synonym_id: 2, id: 1)
gladhappy = SimilarWord.new(word_id: 2, synonym_id: 1, id: 2)
sadupset = SimilarWord.new(word_id: 3, synonym_id: 4, id: 3)
upsetsad = SimilarWord.new(word_id: 4, synonym_id: 3, id: 4)

happysad = OppositeWord.new(word_id: 1, antonym_id: 3, id: 1)
happyupset = OppositeWord.new(word_id: 1, antonym_id: 4, id: 2)
gladsad = OppositeWord.new(word_id: 2, antonym_id: 3, id: 3)
gladupset = OppositeWord.new(word_id: 2, antonym_id: 4, id:4)
sadhappy = OppositeWord.new(word_id: 3, antonym_id: 1, id: 5)
sadglad = OppositeWord.new(word_id: 3, antonym_id: 2, id: 6)
upsethappy = OppositeWord.new(word_id: 4, antonym_id: 1, id: 7)
upsetglad = OppositeWord.new(word_id: 4, antonym_id: 2, id: 8)