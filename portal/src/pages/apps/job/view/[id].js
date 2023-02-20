// ** Demo Components Imports
import JobViewPage from 'src/views/apps/job/view/JobViewPage'

const JobView = ({ id }) => {
  return <JobViewPage id={id} />
}

export async function getServerSideProps({ params }) {
  return {
    props: {
      id: params?.id
    }
  }
}

export default JobView
