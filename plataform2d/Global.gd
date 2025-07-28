extends Node

var from_world


#================= Poderes do player =======================
var pegou_pulo_duplo: bool = false
var pegou_pilula_nanicolina: bool = false
var ativar_pilula: bool = true
var max_jumps : int = 0
var vida_player: int  = 10
var morto: bool = false


func resetar():
	pegou_pulo_duplo = false
	max_jumps = 0
	vida_player = 10
	pegou_pilula_nanicolina = false
