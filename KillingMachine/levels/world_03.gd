extends Node

var gameOver = false
var carrinhu = true
var personagens = []
var personagemAtual = 0
var temChave = false
var temAmp = false
var temShield = false
var jogadoresFinalizados = 0

func _ready():
	personagens.append(get_node("James"))
	personagens.append(get_node("Daron"))
	personagens.append(get_node("Vic"))
	personagens.append(get_node("Josh"))

	for i in range(personagens.size()):
		personagens[i].ativo = (i == personagemAtual)
		
	


func _process(_delta):
	if jogadoresFinalizados == 4:
		$Win.Win("res://levels/world_04.tscn")
		
	if Input.is_action_just_pressed("Trocar_personagem"):
		# Desativar o personagem atual
		personagens[personagemAtual].ativo = false

		# Mudar para o próximo personagem
		personagemAtual += 1
		if personagemAtual >= personagens.size():
			personagemAtual = 0

		# Ativar o novo personagem
		personagens[personagemAtual].ativo = true
	
	if Input.is_action_just_pressed("Voltar_personagem"):
		# Desativar o personagem atual
		personagens[personagemAtual].ativo = false

		# Mudar para o próximo personagem
		personagemAtual -= 1
		if personagemAtual < 0:
			personagemAtual = (personagens.size()) -1

		# Ativar o novo personagem
		personagens[personagemAtual].ativo = true
