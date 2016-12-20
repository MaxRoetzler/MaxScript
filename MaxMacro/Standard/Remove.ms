(
	local Remove = function Remove =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly:
			(
				case subObjectLevel of
				(
					1 : $.Edit_Poly.ButtonOp #RemoveVertex;
					2 : $.Edit_Poly.ButtonOp #RemoveEdge;
					3 : $.Edit_Poly.ButtonOp #RemoveEdge;
				)
			)

			#EditablePoly:
			(
				$.Remove ();
			)

			#EditableLine: 
			(
				SplineOps.Delete $;
			)

			#Selection:
			(
				Delete selection;
			)
		)
	)

	Macro.Remove = Remove;
)