macroScript MaxConvertToEdge category:"Max Core" buttonText:"Convert To Edge" toolTip:"Convert To Edge"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.ConvertSelection #CurrentLevel #Edge;
			subObjectLevel = 2;
		)

		#EditablePoly: 
		(
			if (subObjectLevel == 2) then
			(
				$.CreateShape (UniqueName ($.name + "Shape")) on $;
			)
			else
			(
				$.ConvertSelection #CurrentLevel #Edge;
				subObjectLevel = 2;
			)
		)

		#EditableLine: 
		(
			with Redraw off
			(
				for spline = 1 to (NumSplines $) do
				(
					SetSegSelection $ spline (Core.Line.GetSelectionAsSegment $ spline);
				)

				subObjectLevel = 2;
			)

			CompleteRedraw ();
		)

		#UnwrapUVW: 
		(
			case ($.UnwrapUvw.GetTvSubObjectMode ()) of
			(
				1 : $.UnwrapUvw.VertToEdgeSelect ();
				3 : $.UnwrapUvw.FaceToEdgeSelect ();
			)

			$.UnwrapUvw.SetTVSubObjectMode 2;
		)

		#Selection:
		(
			ConvertToSplineShape $;
			SetCommandPanelTaskMode #Modify;
		)
	)
)