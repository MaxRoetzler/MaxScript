

(
	struct maxPoly
	(
		public Tools,

---------------------------
-- SUB-OBJECT CONVERSION --
---------------------------

		public function GetSelectionAsVertex node =
		(
			/*	Convert the current selection to vertex sub-object level.

				Node			Edt_Poly		The editable node object.

				Return			BitArray		The vertex selection as bitarray.
			*/

			local verts = #{};

			case subObjectLevel of
			(
				1: verts = polyOp.GetVertSelection node;
				2: verts = polyOp.GetVertsUsingEdge node (polyOp.GetEdgeSelection node);
				3: verts = polyOp.GetVertsUsingEdge node (polyOp.GetEdgeSelection node);
				4: verts = polyOp.GetVertsUsingFace node (polyOp.GetFaceSelection node);
				5: verts = polyOp.GetVertsUsingFace node (polyOp.GetFaceSelection node);
			)
		),

		public function GetSelectionAsEdge node =
		(
			/*	Convert the current selection to edge sub-object level.

				Node			Edt_Poly		The editable node object.

				Return			BitArray		The edge selection as bitarray.
			*/

			local edges = #{};

			case subObjectLevel of
			(
				1: edges = polyOp.GetEdgesUsingVert node (polyOp.GetVertSelection node);
				2: edges = polyOp.GetEdgeSelection node;
				3: edges = polyOp.GetEdgeSelection node;
				4: edges = polyOp.GetEdgesUsingFace node (polyOp.GetFaceSelection node);
				5: edges = polyOp.GetEdgesUsingFace node (polyOp.GetFaceSelection node);
			)
		),

		public function GetSelectionAsFace node =
		(
			/*	Convert the current selection to face sub-object level.

				Node			Edt_Poly		The editable node object.

				Return			BitArray		The face selection as bitarray.
			*/

			local faces = #{};

			case subObjectLevel of
			(
				1: faces = polyOp.GetFacesUsingVert node (polyOp.GetVertSelection node);
				2: faces = polyOp.GetFacesUsingEdge node (polyOp.GetEdgeSelection node);
				3: faces = polyOp.GetFacesUsingEdge node (polyOp.GetEdgeSelection node);
				4: faces = polyOp.GetFaceSelection node;
				5: faces = polyOp.GetFaceSelection node;
			)
		),


------------------------
-- SUB-OBJECT MASKING --
------------------------

		public function MarkSubSelection node level indices flag:25 =
		(
			/*	Mark the sub-object level indices in the specified bit.

				Node			Edt_Poly		The editable node object.
				Level			Enum			The sub-object level.
				Indices			BitArray		The sub-object selection.
				Flag			Integer			The bit flag, 25 by default.
			*/

			flag = bit.set 0 flag true;

			case level of
			(
				#Vertex: polyOp.SetVertFlags node indices flag mask:flag;
				#Edge: 	 polyOp.SetEdgeFlags node indices flag mask:flag;
				#Face: 	 polyOp.SetFaceFlags node indices flag mask:flag;
			)
		),

		public function ReadSubSelection node level flag:25 =
		(
			/*	Retreive the sub-object level from the specified bit.

				Node			Edt_Poly		The editable node object.
				Level			Enum			The sub-object level.
				Flag			Integer			The bit flag, 25 by default.
			*/

			flag = bit.set 0 flag true;

			case level of
			(
				#Vertex: polyOp.GetVertsByFlag node flag mask:flag;
				#Edge: 	 polyOp.GetEdgesByFlag node flag mask:flag;
				#Face: 	 polyOp.GetFacesByFlag node flag mask:flag;
			)
		),

		public function WipeSubSelection node level flag:25 =
		(
			/*	Reset the specified bit at the sub-object level.

				Node			Edt_Poly		The editable node object.
				Level			Enum			The sub-object level.
				Flag			Integer			The bit flag, 25 by default.
			*/

			MarkSubSelection node level #{} flag:flag;
		),

----------------------------
-- SUB-OBJECT CALCULATION --
----------------------------

		public function CalculateWeightedCenter node verts: =
		(
			/*	Calculate the center of the vertex selection.
				Convert the current sub-object selection by default.

				Node			Edt_Poly		The editable node object.
				Verts			BitArray		Optional vert list, current selection by default.

				Return			Point3			The vertex selection center.
			*/

			if (verts == unsupplied) do
			(
				verts = GetSelectionAsVertex node;
			)

			local center = Point3 0 0 0;
			local opGetVert = polyOp.GetVert;

			for vert in verts do
			(
				center += opGetVert node vert;
			)

			center / verts.numberSet;
		),

		public function CalculateAbsoluteCenter node verts: =
		(
			/*	Calculate the absolute center of the selected
				vertices' bounding box.

				Node		Edt_Poly		The editable poly object.
				Verts		BitArray		Optional vert list, current selection by default.

				Return		Point3			The bounding box center.
			*/

			if (verts == unsupplied) do
			(
				verts = GetSelectionAsVertex node;
			)

			local opGetVert = polyOp.GetVert;
			local bbMin = Point3  1e9  1e9  1e9;
			local bbMax = Point3 -1e9 -1e9 -1e9;

			for vert in verts do
			(
				pos = opGetVert node vert;

				case of
				(
					(bbMin.x > pos.x) : bbMin.x = pos.x;
					(bbMin.y > pos.y) : bbMin.y = pos.y;
					(bbMin.z > pos.z) : bbMin.z = pos.z;
					(bbMax.x < pos.x) : bbMax.x = pos.x;
					(bbMax.y < pos.y) : bbMax.y = pos.y;
					(bbMax.z < pos.z) : bbMax.z = pos.z;
				)
			)

			(bbMin + bbMax) * 0.5;
		),

		public function CalculateFaceNormal node faces: =
		(
			/*	Calculate the average normal of the face selection.
				Convert the current sub-object selection by default.

				Node			Edt_Poly		The editable node object.
				Faces			BitArray		Optional face list, current selection by default.

				Return			Point3			The average face normal.
			*/

			if (faces == unsupplied) do
			(
				faces = GetSelectionAsFace node;
			)

			local normal = Point3 0 0 0;
			local opGetNormal = polyOp.GetFaceNormal;

			for face in faces do
			(
				normal += opGetNormal node face;
			)

			Normalize normal;
		),

		public function GetSelectionMatrix node verts: faces: =
		(
			/*	Calculate a selection matrix from the average face
				normals and vertex positions. Convert the current
				sub-object selection by default.

				Node			Edt_Poly		The editable node object.
				Verts			BitArray		Optional vert list, current selection by default.
				Faces			BitArray		Optional face list, current selection by default.

				Return			Matrix3			The selection matrix, identity matrix by default.
			*/

			if (verts == unsupplied) do
			(
				verts = GetSelectionAsVertex node;
			)
			
			if (faces == unsupplied) do
			(
				faces = GetSelectionAsFace node;
			)
			
			local matrix;

			matrix = MatrixFromNormal (CalculateFaceNormal node);
			matrix.Row4 = CalculateWeightedCenter node verts:verts;

			matrix;
		),

		public function Transfer node matrix coords verts: =
		(
			/*	Multiply the current sub-object selection by a matrix, in
				the specified coordinate system. Convert the current sub-
				object selection by default.

				Node			Edt_Poly		The editable node object.
				Matrix			Matrix3			The transform matrix.
				Coords			Matrix3			The coordinate system.
			*/

			if (verts == unsupplied) do
			(
				verts = GetSelectionAsVertex node;
			)

			if (verts.Numberset > 0) do
			(
				in coordsys coords
				(
					local index = 0;
					local positions = #();
					local opGetVert = polyOp.GetVert;

					positions[verts.Numberset] = Point3 0 0 0;

					for vert in verts do
					(
						positions[index += 1] = (opGetVert node vert) * matrix;
					)

					polyOp.SetVert node verts positions;
				)
			)
		),

--------------------------
-- SUB-OBJECT OPERATION --
--------------------------

		public function Explode node =
		(
			/*	Explode the specified editable node object into its elements.

				Node			Edt_Poly		The editable node object.
			*/

			local index = 0;
			local name = "";

			while (node.NumFaces > 0) do
			(
				index += 1;
				name = node.name + index as String;

				polyOp.SetFaceSelection node #{1};
				node.SelectElement ();

				polyOp.DetachFaces node (polyOp.GetFaceSelection node) asNode:true name:name;
			)

			Delete node;
		),

		public function SetSmoothGroup node index =
		(
			/*	Assign the specified smoothing group to the current
				sub-object selection. Converts the index to power of
				two format.

				Node			Edt_Poly		The editable node object.
				Index			Integer			The smoothing group index. (1,2,3,4,5 ...)
			*/

			index = if (index == 0) then -2 else index - 1;

			polyOp.SetFaceSmoothGroup node (GetSelectionAsFace node) (2 ^ index);
		),

		public function SetMaterial node index =
		(
			/*	Assign the specified material to the current sub-
				object selection.

				Node			Edt_Poly		The editable node object.
				Index			Integer			The material index.
			*/

			polyOp.SetFaceMatId node (GetSelectionAsFace node) index;
		)
	)

	-- Register to core
	Core.Poly = maxPoly ();
)