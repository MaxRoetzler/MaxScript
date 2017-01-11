macroScript MaxExtrude category:"Max Core" buttonText:"Extrude" toolTip:"Extrude"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			case subObjectLevel of
			(
				1 : $.Edit_Poly.PopupDialog #ExtrudeVertex;
				2 : $.Edit_Poly.PopupDialog #ExtrudeEdge;
				3 : $.Edit_Poly.PopupDialog #ExtrudeEdge;
				4 : $.Edit_Poly.PopupDialog #ExtrudeFace;
				5 : $.Edit_Poly.PopupDialog #ExtrudeFace;
			)
		)

		#EditablePoly: 
		(
			$.PopupDialog #Extrude;
		)
	)
)