(
	local Bridge = function Bridge =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				case subObjectLevel of
				(
					2 : $.Edit_Poly.ButtonOp #BridgeEdge;
					3 : $.Edit_Poly.ButtonOp #BridgeBorder;
					4 : $.Edit_Poly.ButtonOp #BridgePolygon;
				)
			)

			#EditablePoly: 
			(
				$.Bridge ();
			)
		)
	)

	Macro.Bridge = Bridge;
)