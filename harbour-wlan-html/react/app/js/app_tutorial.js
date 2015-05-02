var CommentList = React.createClass({
    render: function() {
        var commentNodes = this.props.data.map(function (comment) {
            return (
                <div className="commentList">
                    <Comment author={comment.author}>{comment.text}</Comment>
                </div>
            );
        });
        return(
            <div className="commentList">
            {commentNodes}
            </div>
        );
    }
});

var CommentForm = React.createClass({
    handleSumit: function(e) {
        e.preventDefault();
        var author = React.findDOMNode(this.refs.author).value.trim();
        var text = React.findDOMNode(this.refs.text).value.trim();
        if (!author || !text) {
            return;
        }
        console.log("test");

        React.findDOMNode(this.refs.author).value = '';
        React.findDOMNode(this.refs.text).value = '';
        return;
    },
    render: function() {
        return (
            <form className="commentForm" onSubmit={this.handleSumit}>
                <input type="text" placeholder="Your name" ref="author"/>
                <input type="text" placeholder="Say something..." ref="text"/>
                <input type="submit" value="Post" />
            </form>
        );
    }
});

var CommentBox = React.createClass({
    loadCommentsFromServer: function() {
        $.ajax({
            url: this.props.url,
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState({data: data});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });
    },
    getInitialState: function() {
        return {data: []};
    },
    componentDidMount: function() {
        this.loadCommentsFromServer();
        setInterval(this.loadCommentsFromServer, this.props.pollIntervall);
    },
    render: function() {
        return (
            <div className="commentBox">
               <h1>Comments</h1>
                <CommentList data={this.state.data}/>
                <CommentForm/>
            </div>
        );
    }
});

var Comment = React.createClass({
    render: function() {
        return (
            <div className="comment">
                <h2 className="commentAuthor">
                    {this.props.author}
                </h2>
                {this.props.children.toString()}
            </div>
        );
    }
});

var data = [
    {author: "andrin bertschi", text: "this is textalsdf ;laskdjflasd;lfjsadf"},
    {author: "andrin kater", text: "this is just some text"}
];

React.render(
    <CommentBox url="data.json" pollIntervall={2000}/>,
    document.getElementById('container')
);