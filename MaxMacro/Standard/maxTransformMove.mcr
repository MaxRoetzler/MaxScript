macroScript MaxTransformMove category:"Max Core" buttonText:"Transform Move" toolTip:"Transform Move"
(
	case (Core.Node.GetObjectType ()) of
	(
		Default 	: max Move;
		#UnwrapUVW	: $.Unwrap_UVW.Move ();
	)
)