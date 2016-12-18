(
	struct maxUnwrap
	(
----------------------------
-- SUB-OBJECT | SELECTION --
----------------------------

		public function SelectLoop node =
		(
			node.UnwrapUvw.UvLoop 0;
		),

		public function SelectRing node =
		(
			node.UnwrapUvw.UvRing 0;
		),

		public function SelectGrow node =
		(
			node.UnwrapUvw.ExpandSelection ();
		),

		public function SelectShrink node =
		(
			node.UnwrapUvw.ContractSelection ();
		),

		public function ConvertToVert node =
		(
			case (node.UnwrapUvw.GetTvSubObjectMode ()) of
			(
				2 : node.UnwrapUvw.EdgeToVertSelect ();
				3 : node.UnwrapUvw.FaceToVertSelect ();
			)

			node.UnwrapUvw.SetTVSubObjectMode 1;
		),

		public function ConvertToEdge node =
		(
			case (node.UnwrapUvw.GetTvSubObjectMode ()) of
			(
				1 : node.UnwrapUvw.VertToEdgeSelect ();
				3 : node.UnwrapUvw.FaceToEdgeSelect ();
			)

			node.UnwrapUvw.SetTVSubObjectMode 2;
		),

		public function ConvertToFace node =
		(
			case (node.UnwrapUvw.GetTvSubObjectMode ()) of
			(
				1 : node.UnwrapUvw.VertToFaceSelect ();
				2 : node.UnwrapUvw.EdgeToFaceSelect ();
			)

			node.UnwrapUvw.SetTVSubObjectMode 3;

		),

		public function ConvertToElement node =
		(
			node.UnwrapUvw.SelectElement ();
		),

----------------------------
-- SUB-OBJECT | OPERATION --
----------------------------

		public function Break node =
		(
			node.UnwrapUvw.BreakSelected ();
		),

		public function Collapse node =
		(
			local uvw = node.UnwrapUvw;

			if (uvw.GetTvSubObjectMode () == 2) do
			(
				local center = uvw.GetSelCenter ();
				local verts = uvw.GetSelectedVertices ();

				for vert in verts do
				(
					uvw.SetVertexPosition2 currentTime vert center true true;
				)

				uvw.WeldSelectedShared ();
			)
		),

		public function Stitch node =
		(
			node.UnwrapUvw.StitchVertsNoParams ();
		),

		public function Weld node =
		(
			node.UnwrapUvw.WeldSelectedShared ();
		)
	)

	Macro.MUvw = maxUnwrap;
)