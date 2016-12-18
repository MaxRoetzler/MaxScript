(
	struct maxEditPoly
	(
	
----------------------
-- NODE | OPERATION --
----------------------

		public function Attach node =
		(
			node.Edit_Poly.EnterPickMode #Attach;
		),

----------------------------
-- SUB-OBJECT | SELECTION --
----------------------------

		public function SelectLoop node =
		(
			node.Edit_Poly.ButtonOp #SelectEdgeLoop;
		),

		public function SelectRing node =
		(
			node.Edit_Poly.ButtonOp #SelectEdgeRing;
		),

		public function SelectGrow node =
		(
			node.Edit_Poly.ButtonOp #GrowSelection;
		),

		public function SelectShrink node =
		(
			node.Edit_Poly.ButtonOp #ShrinkSelection;
		),

		public function ConvertToVert node =
		(
			node.Edit_Poly.ConvertSelection #CurrentLevel #Vertex;
			subObjectLevel = 1;
		),

		public function ConvertToEdge node =
		(
			node.Edit_Poly.ConvertSelection #CurrentLevel #Edge;
			subObjectLevel = 2;
		),

		public function ConvertToFace node =
		(
			node.Edit_Poly.ConvertSelection #CurrentLevel #Face;
			subObjectLevel = 4;
		),

		public function ConvertToElement node =
		(
			with Redraw off
			(
				local level = node.GetEPolySelLevel ();

				node.ConvertSelection #CurrentLevel #Face;
				node.SelectElement ();
				node.ConvertSelection #CurrentLevel level;
			)
		),

----------------------------
-- SUB-OBJECT | OPERATION --
----------------------------

		public function Bevel node =
		(
			node.Edit_Poly.PopupDialog #Bevel;
		),

		public function Break node =
		(
			case subObjectLevel of 
			(
				1 : node.Edit_Poly.ButtonOp #BreakVertex;
				2 : node.Edit_Poly.ButtonOp #SplitEdges;
				3 : node.Edit_Poly.ButtonOp #SplitEdges;
				4 : node.Edit_Poly.ButtonOp #DetachFace;
				5 : node.Edit_Poly.ButtonOp #DetachFace;
			)
		),

		public function Bridge node =
		(
			case subObjectLevel of
			(
				2 : node.Edit_Poly.ButtonOp #BridgeEdge;
				3 : node.Edit_Poly.ButtonOp #BridgeBorder;
				4 : node.Edit_Poly.ButtonOp #BridgePolygon;
			)
		),

		public function Chamfer node =
		(
			case subObjectLevel of
			(
				1 : node.Edit_Poly.PopupDialog #ChamferVertex;
				2 : node.Edit_Poly.PopupDialog #ChamferEdge;
				3 : node.Edit_Poly.PopupDialog #ChamferEdge;
			)
		),

		public function Close node =
		(
			node.Edit_Poly.ButtonOp #Cap;
		),

		public function Collapse node =
		(
			case subObjectLevel of
			(
				1 : node.Edit_Poly.ButtonOp #CollapseVertex;
				2 : node.Edit_Poly.ButtonOp #CollapseEdge;
				3 : node.Edit_Poly.ButtonOp #CollapseEdge;
				4 : node.Edit_Poly.ButtonOp #CollapsePolygon;
			)
		),

		public function Connect node =
		(
			case subObjectLevel of
			(
				1 : node.Edit_Poly.ButtonOp #ConnectVertices;
				2 : node.Edit_Poly.PopupDialog #ConnectEdges;
			)
		),

		public function Constrain node id =
		(
			with undo off
			(
				node.Edit_Poly.ConstrainType = if (node.Edit_Poly.ConstrainType == id) then 0 else id;
			)
		),

		public function Cut node =
		(
			case (subObjectLevel == 4 and node.SelectedFaces.Count > 0) of
			(
				true  : node.Edit_Poly.ToggleCommandMode #Quickslice;
				false : node.Edit_Poly.ToggleCommandMode #Cut;
			)
		),

		public function Create node =
		(
			node.Edit_Poly.ToggleCommandMode #CreateFace;
		),

		public function Detach node =
		(
			local name = UniqueName (node.Name + "Part");
			node.Edit_Poly.DetachToObject name;
		),

		public function Divide node =
		(
			if (subObjectLevel == 2 or subObjectLevel == 3) do
			(
				local edges = node.Edit_Poly.GetSelection #Edge;

				for edge in edges do
				(
					node.Edit_Poly.DivideEdge edge 0.5;
				)
			)
		),

		public function Duplicate node =
		(
			if (subObjectLevel > 3) do
			(
				node.Edit_Poly.ButtonOp #CloneFace;
			)
		),

		public function Extrude node =
		(
			case subObjectLevel of
			(
				1 : node.Edit_Poly.PopupDialog #ExtrudeVertex;
				2 : node.Edit_Poly.PopupDialog #ExtrudeEdge;
				3 : node.Edit_Poly.PopupDialog #ExtrudeEdge;
				4 : node.Edit_Poly.PopupDialog #ExtrudeFace;
				5 : node.Edit_Poly.PopupDialog #ExtrudeFace;
			)
		),

		public function Flatten node =
		(
			print "Not Yet Implemented!";
		),

		public function Inset node =
		(
			if (subObjectLevel > 3) do
			(
				node.Edit_Poly.PopupDialog #Inset;
			)
		),

		public function Material node id =
		(
			node.Edit_Poly.SetOperation #SetMaterial;
			node.Edit_Poly.MaterialIDToSet = id;
		),

		public function Mirror node =
		(
			print "Not Yet Implemented!";
		),

		public function Outline node =
		(
			node.Edit_Poly.PopupDialog #Outline;
		),

		public function Remove node =
		(
			case subObjectLevel of
			(
				1 : node.Edit_Poly.ButtonOp #RemoveVertex;
				2 : node.Edit_Poly.ButtonOp #RemoveEdge;
				3 : node.Edit_Poly.ButtonOp #RemoveEdge;
			)
		),

		public function Smooth node id =
		(
			id = if (id == 0) then -2 else id - 1;

			node.Edit_Poly.SetOperation #SetSmooth;
			node.Edit_Poly.SmoothingGroupsToSet = (2 ^ id);
		),

		public function Weld node =
		(
			if (subObjectLevel == 1) then
			(
				node.Edit_Poly.WeldVertexThreshold = 1e-4;
				node.Edit_Poly.ButtonOp #WeldVertex;
			)
			else if (subObjectLevel == 2 or subObjectLevel == 3) do
			(
				node.Edit_Poly.WeldEdgeThreshold = 1e-4;
				node.Edit_Poly.ButtonOp #WeldEdge;
			)
		)
	)

	Macro.MPoly = maxEditPoly;
)