from godot import exposed, export, Array
from godot import *
import mido

@exposed
class Root(Node2D):
	portlists = export(Array)
	outport = 0
		
	def _ready(self):
		self.portlists = mido.get_output_names()
		
	def ChangePort(self, id):
		self.outport = mido.open_output(self.portlists[id])
	
	def GetPortsSize(self):
		self.portlists = mido.get_output_names()
		return len(self.portlists)
	
	def GetPortName(self, id):
		return self.portlists[id]
	
	def connectport(self, name):
		self.myport.open_output(name)
	
	def note_on(self, key):
		self.outport.send(mido.Message('note_on', note=key))
	
	def note_off(self, key):
		self.outport.send(mido.Message('note_off', note=key))
