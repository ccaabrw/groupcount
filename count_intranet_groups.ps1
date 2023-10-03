# Query intranet group membership of a user
# Sort by group numbers to show hierarchy

param (
  $user = "ccaaxyz"
)

$u = get-aduser $user -properties title,department,memberof

$u | fl name,givenname,surname,title,department

$u.memberof |
sls intranet-groups |% {
	$i = get-adgroup -ldapfilter "(distinguishedname=$_)" -properties members
	new-object psobject -property @{
		group = $i.name
		count = $i.members.count
	}
} | sort-object count
