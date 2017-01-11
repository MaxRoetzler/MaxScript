macroScript MaxBreak category:"Max Core" buttonText:"Break" toolTip:"Break"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			case subObjectLevel of 
			(
				1 : $.Edit_Poly.ButtonOp #BreakVertex;
				2 : $.Edit_Poly.ButtonOp #SplitEdges;
				3 : $.Edit_Poly.ButtonOp #SplitEdges;
				4 : $.Edit_Poly.ButtonOp #DetachFace;
				5 : $.Edit_Poly.ButtonOp #DetachFace;
			)
		)

		#EditablePoly: 
		(
			case subObjectLevel of 
			(
				1 : $.ButtonOp #BreakVertex;
				2 : $.ButtonOp #SplitEdges;
				3 : $.ButtonOp #SplitEdges;
				4 : $.DetachToElement #Face KeepOriginal:false;
				5 : $.DetachToElement #Face KeepOriginal:false;
			)
		)

		#EditableLine: 
		(
			SplineOps.StartBreak $;
		)

		#UnwrapUVW: 
		(
			$.UnwrapUvw.BreakSelected ();
		)
	)
)