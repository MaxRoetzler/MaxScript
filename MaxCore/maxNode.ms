(
	struct maxNode
	(
		public function GetInstances node =
		(
			/*	Get all instances of specified target node.

				@Node		Node		The target object.

				@Return		Array		The instances, or empty array be default.
			*/

			local instances = #();

			InstanceMgr.GetInstances node &instances;

			instances;
		),

		public function IsInstance node =
		(
			/*	Check if a node is instantiated.

				@Node		Node		The target object.

				@Return		Boolean		True, if the object is an instance, otherwise false.
			*/

			(InstanceMgr.GetInstances node #()) > 1;
		),

		public function GetObjectType subLevel:0 =
		(
			/*	Get the handled node or modifier type. Check for
				specific types, selections or return undefined.

				@MinLevel	Integer	Optional minimum sub object level.

				@Return		Enum		The specific object type, #Undefined by default.
			*/

			local type = #Undefined;

			if (selection.count > 0) do
			(
				if (subObjectLevel != undefined and subObjectLevel > subLevel) then
				(
					local currentObj = modPanel.GetCurrentObject ();

					case (ClassOf currentObj) of
					(
						Line			: type = #EditableLine;
						SplineShape		: type = #EditableLine;
						Edit_Poly		: type = #EditPoly;
						Editable_Poly 	: type = #EditablePoly;
						Editable_Mesh	: type = #EditableMesh;
						Unwrap_UVW		: type = #UnwrapUVW;
					)
				)
				else
				(
					type = #Selection;
				)
			)

			type;
		),

		public function GetChildren node excludeParent:true =
		(
			local childs = #(node);

			for child in childs do
			(
				Join childs child.Children;
			)

			if (excludeParent) do DeleteItem childs 1;

			childs;
		),

		public function GetParent node =
		(
			local parent = node;

			while (IsValidNode parent.Parent) do 
			(
				parent = parent.Parent;
			)

			parent;
		)
	)

	-- Register to core.
	Core.Node = maxNode ();
)