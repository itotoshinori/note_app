import moment from 'moment'

export default {
    methods: {
        formatDate(date) {
            date = new Date(date);
            let dateDis = moment(date).format("MM月DD日")
            var WeekChars = ["日", "月", "火", "水", "木", "金", "土"];
            var wDay = date.getDay();
            let dateHour = moment(date).format("HH時mm分")
            return dateDis + " (" + WeekChars[wDay] + ") " + dateHour
        },
        urlCheck(link) {
            if (link.slice(0, 4) == 'http' || link == '') {
                return true
            } else {
                return false
            }
        }
    }
}