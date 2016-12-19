(
	struct maxNode
	(

----------------------
-- NODE | OPERATION --
----------------------

		public function Collapse =
		(
			for node in selection do
			(
				case (SuperClassOf node) of
				(
					Default			: CollapseStack node;
					GeometryClass	: ConvertToPoly node;
					Shape			: ConvertToSplineShape node;
				)
			)

			if (GetCommandPanelTaskMode() != #Modify) do
			(
				SetCommandPanelTaskMode #Modify;
			)
		),

		public function Duplicate =
		(
			local duplicates = #();

			for node in selection do
			(
				case (Core.Node.IsInstance node) of
				(
					true  : Append duplicates (Instance node);
					false : Append duplicates (Copy node);
				)
			)

			select duplicates;
		),

		public function Mirror =
		(
			local coords = Matrix3 1;
			local matrix = Matrix3 1;
			local mirror = Core.Util.GetMirrorMatrix ();

			for node in selection do
			(
				if (node.Parent == undefined or FindItem (selection as Array) node.Parent == 0) do
				(
					matrix = node.Transform;

					if (GetRefCoordSys () == #Local) do
					(
						coords = node.Transform;
					)

					case (GetCoordCenter ()) of
					(
						#Local		:  coords.Row4 = node.pos;
						#Selection	:  coords.Row4 = selection.Center;
					)

					node.Transform = (matrix * Inverse coords) * mirror * coords;
				)
			)
		),

		public function Material id =
		(
			if (id > 0) then
			(
				if (SuperClassOf MeditMaterials[id] != textureMap) do
				(
					for node in selection do
					(
						case (Core.Node.IsInstance node) of
						(
							true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[id]; 
							false : node.material = MeditMaterials[id];
						)
					)
				)
			)
			else for node in selection do node.Material = undefined;
		),

		public function Remove =
		(
			Delete selection;
		)
	)

	Macro.Node = maxNode;
)