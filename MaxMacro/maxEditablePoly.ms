(
	struct maxEditablePoly
	(

----------------------
-- NODE | OPERATION --
----------------------

		public function Attach node =
		(
			node.EnterPickMode #Attach;
		),

----------------------------
-- SUB-OBJECT | SELECTION --
----------------------------

		public function SelectLoop node =
		(
			node.SelectEdgeLoop ();
		),

		public function SelectRing node =
		(
			node.SelectEdgeRing ();
		),

		public function SelectGrow node =
		(
			node.GrowSelection ();
		),

		public function SelectShrink node =
		(
			node.ShrinkSelection ();
		),

		public function ConvertToVert node =
		(
			node.ConvertSelection #CurrentLevel #Vertex;
			subObjectLevel = 1;
		),

		public function ConvertToEdge node =
		(
			node.ConvertSelection #CurrentLevel #Edge;
			subObjectLevel = 2;
		),

		public function ConvertToFace node =
		(
			node.ConvertSelection #CurrentLevel #Face;
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
			node.PopupDialog #Bevel;
		),

		public function Break node =
		(
			case subObjectLevel of 
			(
				1 : node.ButtonOp #BreakVertex;
				2 : node.ButtonOp #SplitEdges;
				3 : node.ButtonOp #SplitEdges;
				4 : node.DetachToElement #Face KeepOriginal:false;
				5 : node.DetachToElement #Face KeepOriginal:false;
			)
		),

		public function Bridge node =
		(
			node.Bridge ();
		),

		public function Chamfer node =
		(
			node.PopupDialog #Chamfer;
		),

		public function Close node =
		(
			node.ButtonOp #Cap;
		),

		public function Collapse node =
		(
			local verts = Core.Poly.GetSelectionAsVertex node;
			verts -= (polyOp.GetVertsByFlag node 8); -- Remove backfacing

			if (verts.Numberset > 0) do
			(
				local constrain = node.ConstrainType;
				local snapData = Core.Util.SnapData ();

				node.ConstrainType = 0;
				Core.Util.SetSnap #(7, 1) #Exclusive;

				local center = Core.Poly.CalculateWeightedCenter node verts:verts;
				local target = PickPoint snap:#3D rubberBand:center;

				if (ClassOf target == Point3) do
				(
					polyOp.SetVert node verts target;
					polyOp.SetVertSelection node verts;
				)

				node.ConnectVertices ();
				node.Collapse #CurrentLevel;
				node.ConstrainType = constrain;
				snapData.Reset ();
			)
		),

		public function Connect node =
		(
			local verts = Core.Poly.GetSelectionAsVertex node;
			verts -= (polyOp.GetVertsByFlag node 8); -- Remove backfacing

			if (verts.Numberset > 3) then
			(
				local constrain = node.ConstrainType;
				local snapData = Core.Util.SnapData ();
				local center = Core.Poly.CalculateWeightedCenter node verts:verts;

				node.ConstrainType = 0;
				Core.Util.SetSnap #(7, 1) #Exclusive;

				local master = undefined;
				local target = PickPoint snap:#3D rubberBand:center;

				if (ClassOf target == Point3) do
				(
					for vert in verts while (master == undefined) do
					(
						if (Length (polyOp.GetVert node vert - target) < 1e-4) do
						(
							master = vert;
						)
					)
				)

				if (master != undefined) then
				(
					for vert in verts do 
					(
						polyOp.CreateEdge node vert master;
					)
				)
				else node.ConnectVertices ();

				node.ConstrainType = constrain;
				snapData.Reset ();
			)
			else node.ConnectVertices ();
		),

		public function Constrain node id =
		(
			with undo off
			(
				node.ConstrainType = if (node.ConstrainType == id) then 0 else id;
			)
		),

		public function Cut node =
		(
			case (subObjectLevel == 4 and node.SelectedFaces.Count > 0) of
			(
				true  : node.ToggleCommandMode #Quickslice;
				false : node.ToggleCommandMode #CutFace;
			)
		),

		public function Create node =
		(
			node.ToggleCommandMode #CreateFace;
		),

		public function Detach node =
		(
			if (subObjectLevel > 3) do
			(
				local name = UniqueName (node.Name + "Part");
				local faces = polyOp.GetFaceSelection node;

				polyOp.DetachFaces node faces delete:true asNode:true name:name;
			)
		),

		public function Divide node =
		(
			if (subObjectLevel == 2 or subObjectLevel == 3) then
			(
				local edges = polyOp.GetEdgeSelection node;

				if (edges.Numberset < 3) then
				(
					for edge in edges do
					(
						polyOp.DivideEdge node edge 0.5;
					)
				)
				else
				(
					node.connectEdgeSegments = 1;
					node.ConnectEdges ();
				)
			)
			else if (subObjectLevel == 4) do
			(
				node.Tessellate #Face;
			)
		),

		public function Duplicate node =
		(
			if (subObjectLevel > 3) do
			(
				local faces = polyOp.GetFaceSelection node;

				polyOp.DetachFaces node faces delete:false asNode:false;
				polyOp.SetFaceSelection node ((polyOp.GetFaceSelection node) - faces);
			)
		),

		public function Extrude node =
		(
			node.PopupDialog #Extrude;
		),

		public function Flatten node =
		(
			local matrix = Matrix3 1;
			local verts = Core.Poly.GetSelectionAsVertex node;

			case (GetRefCoordSys ()) of
			(
				#Local	: matrix = Core.Poly.GetSelectionMatrix node;
				#Hybrid	: matrix.Row4 = Core.Poly.CalculateWeightedCenter node verts:verts;
			)

			Core.Poly.Transfer node (Core.Util.GetFlattenMatrix ()) matrix;
		),

		public function Inset node =
		(
			if (subObjectLevel > 3) do
			(
				node.PopupDialog #Inset;
			)
		),

		public function Material node id =
		(
			local faces = Core.Poly.GetSelectionAsFace node;

			polyOp.SetFaceMatID node faces id;
		),

		public function Mirror node =
		(
			local matrix = Matrix3 1;
			local axis = toolmode.AxisConstraints;
			local faces = Core.Poly.GetSelectionAsFace node;
			local verts = Core.Poly.GetSelectionAsVertex node;

			case (GetRefCoordSys ()) of
			(
				#Local	: matrix = Core.Poly.GetSelectionMatrix node verts:verts faces:faces;
				#Hybrid	: matrix.Row4 = Core.Poly.CalculateWeightedCenter node verts:verts;
			)

			if (subObjectLevel > 3 and axis == #X or axis == #Y or axis == #Z) do
			(
				polyOp.FlipNormals node faces;
			)

			Core.Poly.Transfer node (Core.Util.GetMirrorMatrix ()) matrix verts:verts;
		),

		public function Outline node =
		(
			node.PopupDialog #Outline;
		),

		public function Remove node =
		(
			node.Remove ();
		),

		public function Smooth node id =
		(
			local faces = Core.Poly.GetSelectionAsFace node;
			id = if (id == 0) then -2 else id - 1;

			polyOp.SetFaceSmoothGroup node faces (2 ^ id);
		),

		public function Weld node =
		(
			node.WeldThreshold = 1e-3;
			node.ButtonOp #WeldSelected;
		)
	)

	Macro.EPoly = maxEditablePoly;
)