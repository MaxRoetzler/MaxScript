(
	local TransformMove = function TransformMove =
	(
		case (Core.Node.GetObjectType ()) of
		(
			Default 	: max Move;
			#UnwrapUVW	: $.Unwrap_UVW.Move ();
		)
	)

	Macro.TransformMove = TransformMove;
)