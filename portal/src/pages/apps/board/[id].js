// ** Demo Components Imports
import BoardViewPage from 'src/views/apps/board/BoardViewPage'

const BoardView = ({ id }) => {
  return <BoardViewPage id={id} />
}

export async function getServerSideProps({ params }) {
  return {
    props: {
      id: params?.id
    }
  }
}

export default BoardView
