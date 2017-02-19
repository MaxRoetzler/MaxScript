macroScript MaxCollapse category:"Max Core" buttonText:"Collapse" toolTip:"Collapse"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			case subObjectLevel of
			(
				1 : $.Edit_Poly.ButtonOp #CollapseVertex;
				2 : $.Edit_Poly.ButtonOp #CollapseEdge;
				3 : $.Edit_Poly.ButtonOp #CollapseEdge;
				4 : $.Edit_Poly.ButtonOp #CollapsePolygon;
			)
		)

		#EditablePoly: 
		(
			if (subObjectLevel == 1) then
			(
				-- MOVE TO CORE.POLY
				local verts = Core.Poly.GetSelectionAsVertex $;
				-- ONLY MAKES SENSE IN SUB-OBJECT-LEVEL 1 (?)
				verts -= (polyOp.GetVertsByFlag $ 8); -- Remove backfacing

				if (verts.Numberset > 0) do
				(
					local constrain = $.ConstrainType;
					local snapData = Core.Util.SnapData ();

					$.ConstrainType = 0;
					Core.Util.SetSnap #(7, 1) #Exclusive;

					local center = Core.Poly.CalculateWeightedCenter $ verts:verts;
					local target = PickPoint snap:#3D rubberBand:center;

					if (ClassOf target == Point3) do
					(
						polyOp.SetVert $ verts target;
						polyOp.SetVertSelection $ verts;
					)

					$.ConnectVertices ();
					$.Collapse #CurrentLevel;
					$.ConstrainType = constrain;
					snapData.Reset ();
				)
			)
			else $.Collapse #CurrentLevel;
		)

		#EditableLine: 
		(
			SplineOps.Fuse $;
			WeldSpline $ 1e-3;
		)

		#UnwrapUVW: 
		(
			with Redraw off
			(
				local uvw = $.UnwrapUvw;

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
			)

			CompleteRedraw ();
		)

		#Selection:
		(
			CollapseStack $;
			SetCommandPanelTaskMode #Modify;
		)
	)
)