# THIS SEED FILE NEEDS TO BE ENTIRELY REPLACED -- I'M LEAVING CODE FOR YOUR REFERENCE ONLY!

User.destroy_all
User.reset_pk_sequence
Word.destroy_all
Word.reset_pk_sequence
VocabList.destroy_all
VocabList.reset_pk_sequence
UserList.destroy_all
UserList.reset_pk_sequence
SimilarWord.destroy_all
SimilarWord.reset_pk_sequence
OppositeWord.destroy_all
OppositeWord.reset_pk_sequence
WordListRelation.destroy_all
WordListRelation.reset_pk_sequence

########### different ways to write your seeds ############

gabe = User.create(name:'gabriel d', username: 'gabed', password: '123456')
dayne = User.create(name: 'dayne d', username: 'dayned', password: '654321' )

happylist = VocabList.create(name: 'happy list')
sadlist = VocabList.create(name: 'sad list')

happy = Word.create(word: 'happy', definition: 'to be happy')
glad = Word.create(word: 'glad', definition: 'to be glad')
sad = Word.create(word: 'sad', definition: 'to be sad')
upset = Word.create(word: 'upset', definition: 'to be upset')

happy_happy = WordListRelation.create(vocab_list_id: 1, word_id: 1, user_id: 1)
happy_glad = WordListRelation.create(vocab_list_id: 1, word_id: 2, user_id: 1)
sad_sad = WordListRelation.create(vocab_list_id: 2, word_id: 3, user_id: 2)
sad_upset = WordListRelation.create(vocab_list_id: 2, word_id: 4, user_id: 2)


gabesvocab = UserList.create(user_id: 1, vocab_list_id: 1)
daynesvocab = UserList.create(user_id: 2, vocab_list_id: 2)

happyglad = SimilarWord.create(word_id: 1, synonym_id: 2)
gladhappy = SimilarWord.create(word_id: 2, synonym_id: 1)
sadupset = SimilarWord.create(word_id: 3, synonym_id: 4)
upsetsad = SimilarWord.create(word_id: 4, synonym_id: 3)

happysad = OppositeWord.create(word_id: 1, antonym_id: 3)
happyupset = OppositeWord.create(word_id: 1, antonym_id: 4)
gladsad = OppositeWord.create(word_id: 2, antonym_id: 3)
gladupset = OppositeWord.create(word_id: 2, antonym_id: 4)
sadhappy = OppositeWord.create(word_id: 3, antonym_id: 1)
sadglad = OppositeWord.create(word_id: 3, antonym_id: 2)
upsethappy = OppositeWord.create(word_id: 4, antonym_id: 1)
upsetglad = OppositeWord.create(word_id: 4, antonym_id: 2)


puts "🔥 🔥 🔥 🔥 "