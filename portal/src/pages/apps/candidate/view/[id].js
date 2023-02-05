// ** Third Party Imports
import axios from 'axios'

// ** Demo Components Imports
import CandidateViewPage from 'src/views/apps/candidate/view/CandidateViewPage'

const CandidateView = ({ id }) => {
  return <CandidateViewPage id={id} />
}

export async function getServerSideProps({ params }) {
  return {
    props: {
      id: params?.id
    }
  }
}

export default CandidateView
