// ** Demo Components Imports
import ClientViewPage from 'src/views/apps/client/view/ClientViewPage'

const ClientView = ({ id }) => {
  return <ClientViewPage id={id} />
}

export async function getServerSideProps({ params }) {
  return {
    props: {
      id: params?.id
    }
  }
}

export default ClientView
