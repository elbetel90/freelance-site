const express = require("express");
const bodyParser = require("body-parser");
const morgan = require("morgan");
const cors = require("cors");
const userRouter = require("./routes/user.route");
const jobRouter = require("./routes/job.route");
const authRouter = require("./routes/auth.route");
const customerRouter = require("./routes/customer.route");
const freelancerRouter = require("./routes/freelancer.route");
const proposalRouter = require("./routes/proposal.route");
const BadRequestError = require("./utils/error");
const errorController = require("./controllers/error.controller");

const app = express();

if (process.env.NODE_ENV === "development") {
    app.use(morgan("dev"));
}

app.use(cors());
app.use("*", cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(`${__dirname}/public`));

app.use("/users", userRouter);
app.use("/", freelancerRouter);
app.use("/auth", authRouter);
app.use("/jobs", jobRouter);
app.use("/customers", jobRouter);
app.use("/potential", customerRouter);
app.use("/potential", freelancerRouter);
app.use("/", proposalRouter);

app.get("/", (req, res) => {
    res.status(200).json({
        status: "success",
        message: "HOME PAGE",
    });
});

// error middleware - unhadled route
app.use("*", (req, res, next) => {
    next(
        new BadRequestError(
            `Can't find ${req.originalUrl} on this server!`,
            404
        )
    );
});

// global error handler
app.use(errorController);

module.exports = app;
