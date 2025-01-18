{
    "metadata": {
        "kernelspec": {
            "name": "SQL",
            "display_name": "SQL",
            "language": "sql"
        },
        "language_info": {
            "name": "sql",
            "version": ""
        }
    },
    "nbformat_minor": 2,
    "nbformat": 4,
    "cells": [
        {
            "cell_type": "code",
            "source": [
                "-- 1.\r\n",
                "SELECT c.cid, c.name from Customer c \r\n",
                "LEFT JOIN Ordered o ON c.cid = o.cid\r\n",
                "LEFT JOIN Tour t ON o.tid = t.tid\r\n",
                "LEFT JOIN TourGuide tg ON t.tgid = tg.tgid\r\n",
                "WHERE c.frequentTravelerStatus = 'silver' AND tg.name = 'B. Grylls'"
            ],
            "metadata": {
                "azdata_cell_guid": "a94f60b0-fb93-4955-bd68-8d971b0a3d6f",
                "language": "sql",
                "tags": []
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.029"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 2,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "cid"
                                    },
                                    {
                                        "name": "name"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "cid": "2",
                                    "name": "Sabina"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>cid</th><th>name</th></tr>",
                            "<tr><td>2</td><td>Sabina</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "error",
                    "evalue": "Msg 2812, Level 16, State 62, Line 1\r\nCould not find stored procedure '#'.",
                    "ename": "",
                    "traceback": []
                }
            ],
            "execution_count": 2
        },
        {
            "cell_type": "code",
            "source": [
                "-- 2.\r\n",
                "SELECT MAX(c.age) AS oldest_age\r\n",
                "FROM customer c\r\n",
                "JOIN ordered o ON c.cid = o.cid\r\n",
                "JOIN tour t ON o.tid = t.tid\r\n",
                "JOIN tourGuide tg ON t.tgid = tg.tgid\r\n",
                "WHERE c.countryOfResidence = 'Germany' OR tg.name = 'B. Grylls';"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "58a6eefb-8ef3-49f4-b5c5-9013b65a246f"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.031"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 3,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "oldest_age"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "oldest_age": "70"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>oldest_age</th></tr>",
                            "<tr><td>70</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "error",
                    "evalue": "Msg 2812, Level 16, State 62, Line 1\r\nCould not find stored procedure '#'.",
                    "ename": "",
                    "traceback": []
                }
            ],
            "execution_count": 3
        },
        {
            "cell_type": "code",
            "source": [
                "-- 3.\r\n",
                "SELECT DISTINCT t.destinationCountry AS tourName\r\n",
                "FROM tour t\r\n",
                "WHERE t.destinationCountry = 'Oman' OR t.tid IN (\r\n",
                "    SELECT o.tid FROM Ordered o \r\n",
                "    GROUP BY o.tid HAVING COUNT(DISTINCT o.cid) >= 5)"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "fddbbb4e-17c1-4402-b229-bca1492fd637"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(2 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.056"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 4,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "tourName"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "tourName": "Bosnia and Herzegovina"
                                },
                                {
                                    "tourName": "Oman"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>tourName</th></tr>",
                            "<tr><td>Bosnia and Herzegovina</td></tr>",
                            "<tr><td>Oman</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 4
        },
        {
            "cell_type": "code",
            "source": [
                "-- 4.\r\n",
                "SELECT c.cid, c.name FROM Customer c \r\n",
                "JOIN Ordered o ON c.cid = o.cid\r\n",
                "JOIN Tour t ON o.tid = t.tid\r\n",
                "GROUP BY t.tourDate, c.cid, c.name \r\n",
                "HAVING (COUNT(t.tid)>=2)"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "c7c14d2f-f276-4578-b4e9-442ab0116348"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(3 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.066"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 11,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "cid"
                                    },
                                    {
                                        "name": "name"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "cid": "1",
                                    "name": "Linda"
                                },
                                {
                                    "cid": "2",
                                    "name": "Sabina"
                                },
                                {
                                    "cid": "3",
                                    "name": "John"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>cid</th><th>name</th></tr>",
                            "<tr><td>1</td><td>Linda</td></tr>",
                            "<tr><td>2</td><td>Sabina</td></tr>",
                            "<tr><td>3</td><td>John</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 11
        },
        {
            "cell_type": "code",
            "source": [
                "-- 5.\r\n",
                "SELECT tg.tgid, tg.name FROM TourGuide tg\r\n",
                "JOIN tour t ON tg.tgid = t.tgid\r\n",
                "GROUP BY tg.tgid, tg.name\r\n",
                "HAVING COUNT(DISTINCT t.destinationCountry) = (SELECT COUNT(DISTINCT t.destinationCountry) FROM Tour t)"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "d2dd9860-c681-41ea-8e79-f25274d71619"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.032"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 12,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "tgid"
                                    },
                                    {
                                        "name": "name"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "tgid": "1",
                                    "name": "Kamber"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>tgid</th><th>name</th></tr>",
                            "<tr><td>1</td><td>Kamber</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 12
        },
        {
            "cell_type": "code",
            "source": [
                "-- 6.\r\n",
                "SELECT TG.name, TG.tgid FROM TourGuide TG\r\n",
                "JOIN Tour t ON TG.tgid = t.tgid\r\n",
                "GROUP BY TG.tgid, TG.name\r\n",
                "HAVING COUNT(t.tid) < 3"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "02f20146-296f-4897-81a0-a2c4d99d4dc9"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(3 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.044"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 13,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "name"
                                    },
                                    {
                                        "name": "tgid"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "name": "Manuel",
                                    "tgid": "2"
                                },
                                {
                                    "name": "B. Grylls",
                                    "tgid": "3"
                                },
                                {
                                    "name": "RandomGuy",
                                    "tgid": "5"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>name</th><th>tgid</th></tr>",
                            "<tr><td>Manuel</td><td>2</td></tr>",
                            "<tr><td>B. Grylls</td><td>3</td></tr>",
                            "<tr><td>RandomGuy</td><td>5</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 13
        },
        {
            "cell_type": "code",
            "source": [
                "-- 7.\r\n",
                "SELECT AVG(age) as averageAge, frequentTravelerStatus \r\n",
                "FROM Customer \r\n",
                "WHERE age > 40 \r\n",
                "GROUP BY  frequentTravelerStatus\r\n",
                "HAVING AVG(age) < 50\r\n",
                ""
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "08f6a0ba-7db3-4aa9-8dce-47ae52131f3a",
                "tags": []
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.030"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 16,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "averageAge"
                                    },
                                    {
                                        "name": "frequentTravelerStatus"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "averageAge": "46",
                                    "frequentTravelerStatus": "silver"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>averageAge</th><th>frequentTravelerStatus</th></tr>",
                            "<tr><td>46</td><td>silver</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 16
        },
        {
            "cell_type": "code",
            "source": [
                "-- 8.\r\n",
                "SELECT tg.tgid, tg.name, COUNT(t.tid) AS total_tours\r\n",
                "FROM tourGuide tg\r\n",
                "JOIN tour t ON tg.tgid = t.tgid\r\n",
                "GROUP BY tg.tgid, tg.name\r\n",
                "HAVING COUNT(DISTINCT t.destinationCountry) = 1\r\n",
                "   AND MAX(t.destinationCountry) = 'Oman';"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "40e0fde4-12b2-44e1-800c-96afffbb9692"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.023"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 29,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "tgid"
                                    },
                                    {
                                        "name": "name"
                                    },
                                    {
                                        "name": "total_tours"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "tgid": "5",
                                    "name": "RandomGuy",
                                    "total_tours": "2"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>tgid</th><th>name</th><th>total_tours</th></tr>",
                            "<tr><td>5</td><td>RandomGuy</td><td>2</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 29
        },
        {
            "cell_type": "code",
            "source": [
                "-- 9.\r\n",
                "SELECT c.cid, c.name\r\n",
                "FROM customer c\r\n",
                "JOIN ordered o ON c.cid = o.cid\r\n",
                "GROUP BY c.cid, c.name\r\n",
                "HAVING COUNT(o.tid) = (SELECT COUNT(DISTINCT t.tid) FROM tour t)"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "d332cc83-a135-40c2-a833-864e7ffb1f4d"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(0 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.032"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "cid"
                                    },
                                    {
                                        "name": "name"
                                    }
                                ]
                            },
                            "data": []
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>cid</th><th>name</th></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 19
        },
        {
            "cell_type": "code",
            "source": [
                "-- 10.\r\n",
                "SELECT * FROM Customer c WHERE c.cid NOT IN (SELECT DISTINCT(o.cid) FROM Ordered o)"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "b2283d9a-340f-47ea-bb13-5c792838abfc"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.034"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 20,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "cid"
                                    },
                                    {
                                        "name": "name"
                                    },
                                    {
                                        "name": "countryOfResidence"
                                    },
                                    {
                                        "name": "age"
                                    },
                                    {
                                        "name": "frequentTravelerStatus"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "cid": "7",
                                    "name": "Peter",
                                    "countryOfResidence": "Germany",
                                    "age": "70",
                                    "frequentTravelerStatus": "diamond"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>cid</th><th>name</th><th>countryOfResidence</th><th>age</th><th>frequentTravelerStatus</th></tr>",
                            "<tr><td>7</td><td>Peter</td><td>Germany</td><td>70</td><td>diamond</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 20
        },
        {
            "cell_type": "code",
            "source": [
                "-- 11.\r\n",
                "WITH StatusCounts AS (\r\n",
                "    SELECT c.age, c.frequentTravelerStatus,\r\n",
                "           COUNT(*) AS status_count,\r\n",
                "           ROW_NUMBER() OVER (PARTITION BY c.age ORDER BY COUNT(*) DESC) AS sequence_number\r\n",
                "    FROM customer c\r\n",
                "    GROUP BY c.age, c.frequentTravelerStatus\r\n",
                ")\r\n",
                "SELECT age, frequentTravelerStatus, status_count\r\n",
                "FROM StatusCounts\r\n",
                "WHERE sequence_number = 1;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "24c8de69-f7e5-40bd-a4da-1cc0d49505cd",
                "tags": []
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(5 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.100"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 28,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "age"
                                    },
                                    {
                                        "name": "frequentTravelerStatus"
                                    },
                                    {
                                        "name": "status_count"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "age": "26",
                                    "frequentTravelerStatus": "diamond",
                                    "status_count": "2"
                                },
                                {
                                    "age": "45",
                                    "frequentTravelerStatus": "diamond",
                                    "status_count": "1"
                                },
                                {
                                    "age": "46",
                                    "frequentTravelerStatus": "silver",
                                    "status_count": "1"
                                },
                                {
                                    "age": "66",
                                    "frequentTravelerStatus": "platinum",
                                    "status_count": "1"
                                },
                                {
                                    "age": "70",
                                    "frequentTravelerStatus": "diamond",
                                    "status_count": "1"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>age</th><th>frequentTravelerStatus</th><th>status_count</th></tr>",
                            "<tr><td>26</td><td>diamond</td><td>2</td></tr>",
                            "<tr><td>45</td><td>diamond</td><td>1</td></tr>",
                            "<tr><td>46</td><td>silver</td><td>1</td></tr>",
                            "<tr><td>66</td><td>platinum</td><td>1</td></tr>",
                            "<tr><td>70</td><td>diamond</td><td>1</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 28
        }
    ]
}