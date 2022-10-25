// ** React Imports
import { useState } from 'react'

// ** Next Imports
import { useRouter } from 'next/router'

// ** Context Imports
import { AbilityContext } from 'src/layouts/components/acl/Can'

// ** Config Import
import { buildAbilityFor } from 'src/configs/acl'

// ** Component Import
import NotAuthorized from 'src/pages/401'
import BlankLayout from 'src/@core/layouts/BlankLayout'

import { useUser } from '@auth0/nextjs-auth0';

const AclGuard = props => {
  // ** Props
  const { aclAbilities, children } = props
  const [ability, setAbility] = useState(undefined)

  // ** Hooks
  const router = useRouter()
  const user = useUser();

  // User is logged in, build ability for the user based on his role
  if (user && !ability) {
    setAbility(buildAbilityFor("", aclAbilities.subject))
  }

  // Check the access of current user and render pages
  if (ability && ability.can(aclAbilities.action, aclAbilities.subject)) {
    return <AbilityContext.Provider value={ability}>{children}</AbilityContext.Provider>
  }

  // Render Not Authorized component if the current user has limited access
  return (
    <BlankLayout>
      <NotAuthorized />
    </BlankLayout>
  )
}

export default AclGuard
