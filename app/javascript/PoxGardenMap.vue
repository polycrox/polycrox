
<template>
    <div>
        TODO:
        <ul>
            <li style='text-decoration:line-through'>Fill a bed when borders are closed</li>
            <li style='text-decoration:line-through'>Save bed's position in the database</li>
            <li style='text-decoration:line-through'>Re-draw a bed from its position saved in the database</li>
            <li>Draw a polygon by clicking to create points and link them with lines.</li>
            <li>Automatically calculate dimensions + <span style='text-decoration:line-through'>perimeter</span> + area</li>
            <li>Save ratio (e.g: 100px = 1m, ...) in the geometry</li>
            <li>Draw curves for more complex shapes</li>
            <li>Toggle Square foot Grid in a bed</li>
            <li>Drag and drop beds</li>
            <li>Refactor `_drawPoint` and `_drawLine`</li>
        </ul>
        <canvas
            id="tutorial" width="800" height="600"
            v-on:click='clickCanvas'
            v-on:mousemove='selectShapes'>
        </canvas>

        <form
            v-if='isModeFormEditing'>
            <label>Shape's name:</label>
            <input 
                type='text' 
                v-model.lazy='currentShape.name' />
            
            <label>Shape's points:</label>
            <textarea
                v-model.lazy='currentShape.points_json'>        
            </textarea>

            <input 
                type='submit'
                v-on:click='saveCurrentShape' />

        </form>

        <button
            v-on:click='drawPolygon'>
            Draw Polygon
        </button>

        <button
            v-on:click='closePolygon'>
            close Polygon
        </button>

        <button
            v-on:click='toggleModeSelection'>
            Mode Selection: {{ isModeSelection }}
        </button>
        
        <br />

        <button
            v-on:click='displayGardenGrid'>
            Toggle Garden Grid
        </button>
        
    </div>
</template>
<script>
    
    function initShape() {
        return {
            path2d: new Path2D(),
            points: [],
            points_json: null,
            name: null
        }
    }
    export default {
        props: ['plots', 'garden_id'],
        data: function() {
            return {
                cursor: {
                    position: {
                        x: null,
                        y: null
                    },
                    direction: 'east'
                },
                margin: 20,
                line: {
                    angle: 0,
                    length: 50
                },
                isModeDrawing: false,
                isModeSelection: false,
                isModeFormEditing: false,
                isDrawingSquareBox: false,
                startLine: null,
                stopLine: null,
                canvas: null,
                ctx: null,
                showGardenGrid: false,
                currentShape: initShape(),
                shapes: [],
                defaultRatio: 100  // 100px = 1m
            }
        },
        mounted: function() {
            this.canvas = document.getElementById('tutorial')
            this.ctx = this.canvas.getContext('2d')
            this.map = {
                width: this.canvas.width - this.margin,
                height: this.canvas.height - this.margin,
                origin: {
                    x: this.margin,
                    y: this.margin
                }
            }

            this.cursor = {
                position: {
                    x: this.map.origin.x,
                    y: this.map.origin.y
                },
                direction: 'east'
            }

            this.displayGardenGrid()

            this.ctx.strokeStyle = 'orange'
            this.ctx.fillStyle = 'black'
            this.ctx.setLineDash([])

            // Draw plots
            this.drawPlots(this.plots)

        },
        created: 
        methods: {
            clickCanvas: function(event) {
                if (!this.currentShape) {
                    this.currentShape = initShape()
                }

                this.moveCursor(e)
                this.savePointOfCurrentShape();

                if (!this.isModeDrawing) {

                    this.isModeDrawing = true
                    this.cursor = {
                        position: {
                            x: e.layerX,
                            y: e.layerY
                        },
                        direction: 'east'
                    }

                    this.currentShape = initShape()
                    this.currentShape.path2d.moveTo(this.cursor.position.x, this.cursor.position.y);
                    this.savePointOfCurrentShape();

                } else if (this.drawPolygon) {
                    this.currentShape.path2d.moveTo(this.cursor.position.x, this.cursor.position.y);

                    this.drawCircle(this.cursor.position.x, this.cursor.position.y)
                } else {
                    alert('already in drawing mode.')
                }
            },
            closePolygon: function() {
                let _polygonShape = this._drawPoints(initShape(), this.currentShape.points)
                this.drawPolygon = false

                this.exportCurrentShapePointsToJSON()
                this.isModeFormEditing = true
            },
            moveCursor: function(e) {
                this.cursor.position.x = e.layerX                        
                this.cursor.position.y = e.layerY
            },
            drawCircle: function(x, y) {
                this.ctx.fillStyle = 'red';
                
                let _circle = new Path2D()
                _circle.arc(x, y, 5, 0, 2 * Math.PI);
                
                this.ctx.fill(_circle);

                this.currentShape.path2d.addPath(_circle)

            },
            toggleModeSelection: function() {
                this.isModeSelection = !this.isModeSelection
            },
            selectShapes: function(event) {
                if (this.isModeSelection) {
                    this.shapes.forEach((shape, i) => {
                        if (this.ctx.isPointInPath(this.shapes[i].path2d, event.offsetX, event.offsetY)) {
                            let perimeter = this.calcPerimeter(this.shapes[i])
                            console.log('yes, in shape', i, this.shapes[i].name, '. Perimeter: ', perimeter)

                        }
                    })
                }                
            },
            _drawLine: function(source, position, style) {
                this.ctx.lineWidth = style.lineWidth;
                this.ctx.strokeStyle = style.strokeStyle;
                if (style.line == 'straight') {
                    this.ctx.setLineDash([])    
                }
                
                
                // that was my bug!!!
                // this.currentShape.moveTo(this.cursor.position.x, this.cursor.position.y);

                source.lineTo(position.x, position.y);
                this.ctx.stroke(source)
                
            },
            displayGardenGrid: function() {
                // 100 px = 1 m
                if (this.showGardenGrid) {
                    return
                }
                this.showGardenGrid = true

                this._drawBorders()

                let metersScale = {
                    ratio: 100,
                    lineWidth: 3,
                    strokeStyle: 'blue'
                }
                let halfMetersScale = {
                    ratio: 50,
                    lineWidth: 1,
                    strokeStyle: 'green'
                }
                this._displayGardenGridXScale(halfMetersScale, false)
                this._displayGardenGridXScale(metersScale, true)
                


                this._displayGardenGridYScale(metersScale, true)
                this._displayGardenGridYScale(halfMetersScale, false)
                
            },
            _drawBorders: function() {
                this.ctx.lineWidth = 1;
                this.ctx.strokeStyle = 'black';

                // draw top border
                this.ctx.beginPath()
                this.ctx.moveTo(this.margin, this.margin);
                this.ctx.lineTo(this.map.width, this.margin); 
                this.ctx.stroke();
                this.ctx.closePath()
                
                //  draw right border
                this.ctx.beginPath()
                this.ctx.moveTo(this.map.width, this.margin);
                this.ctx.lineTo(this.map.width, this.map.height); 
                this.ctx.stroke();
                this.ctx.closePath()

                // draw bottom border
                this.ctx.beginPath()
                this.ctx.moveTo(this.margin, this.map.height);
                this.ctx.lineTo(this.map.width, this.map.height); 
                this.ctx.stroke();
                this.ctx.closePath()

                // draw left border
                this.ctx.beginPath()
                this.ctx.moveTo(this.margin, this.margin);
                this.ctx.lineTo(this.margin, this.map.height); 
                this.ctx.stroke();
                this.ctx.closePath()
            },
            _displayGardenGridXScale: function(scale, drawGrid) {                                

                let x = this.margin
                while (x <= this.map.width) {

                    // draw scale
                    this.ctx.beginPath()

                    this.ctx.lineWidth = scale.lineWidth;
                    this.ctx.strokeStyle = scale.strokeStyle;

                    this.ctx.moveTo(x, this.margin);
                    this.ctx.lineTo(x, this.margin + 7);
                    
                    this.ctx.stroke();
                    this.ctx.closePath()

                    // draw grid
                    if (drawGrid && x > this.margin && x < this.map.width) {
                        this.ctx.beginPath()

                        this.ctx.lineWidth = 1;
                        this.ctx.strokeStyle = 'black';
                        this.ctx.setLineDash([5, 10]);
                        this.ctx.moveTo(x, this.margin);
                        this.ctx.lineTo(x, this.map.height); 
                        this.ctx.stroke();

                        this.ctx.closePath()
                    }

                    x += scale.ratio
                }
            },
            _displayGardenGridYScale: function(scale, drawGrid) {                                

                let y = this.margin
                while (y <= this.map.height) {
                    this.ctx.beginPath()
                    
                    this.ctx.lineWidth = scale.lineWidth;
                    this.ctx.strokeStyle = scale.strokeStyle;
                    
                    this.ctx.moveTo(this.margin, y);
                    this.ctx.lineTo(5, y); 

                    this.ctx.stroke();
                    this.ctx.closePath()

                    if (drawGrid && y > this.margin && y < this.map.height) {
                        this.ctx.beginPath()
                        
                        this.ctx.lineWidth = 1;
                        this.ctx.strokeStyle = 'black';
                        this.ctx.setLineDash([5, 10]);
                        this.ctx.moveTo(this.margin, y);
                        this.ctx.lineTo(this.map.width, y);
                        this.ctx.stroke();

                        this.ctx.closePath()
                    } 


                    y += scale.ratio
                }
            },
            savePointOfCurrentShape: function() {
                this.currentShape.points.push(Object.assign({}, this.cursor.position))
            },
            exportCurrentShapePointsToJSON: function() {
                this.currentShape.points_json = JSON.stringify(this.currentShape.points)
            },
            saveCurrentShape: function(e) {
                e.preventDefault()
                
                let csrfToken = document.querySelector("meta[name='csrf-token']").content

                this.$http.post('/plots/', {
                    plot: {
                        garden_id: this.garden_id,
                        name: this.currentShape.name,
                        geometry: this.currentShape.points_json
                    }
                }, {
                    headers: {
                        'X-CSRF-Token': csrfToken
                    }
                }).then(response => {
                   console.log(response)
                }, response =>{
                    console.log('fail createItem')
                })
            },
            drawPlots: function(plots) {
                plots.forEach((plot) => {
                    if (plot.geometry) {
                        let _geom = JSON.parse(plot.geometry)
                        let _shape = initShape()
                        
                        _shape.points = _geom
                        _shape.name = plot.name




                        let _plotShape = this._drawPoints(_shape, _geom)
                        this.shapes.push(_plotShape)

                    }
                })
            },
            _drawPoints: function(shapeSource, points) {
                points.forEach((point) => {
                    this._drawPoint(shapeSource, point)
                })

                shapeSource.path2d.closePath()
                this.ctx.fillStyle = 'black';
                this.ctx.fill(shapeSource.path2d);

                this.ctx.strokeStyle = 'red';
                this.ctx.stroke(shapeSource.path2d);

                return shapeSource
            },
            _drawPoint: function(shapeSource, point) {
                shapeSource.path2d.lineTo(point.x, point.y);
                this.ctx.stroke(shapeSource.path2d)
            },
            calcPerimeter: function(shape) {
                let perimeter = 0
                shape.points.forEach((point, i) => {
                    let point2
                    if (shape.points[i + 1]) {
                        point2 = shape.points[i + 1]
                    } else {
                        point2 = shape.points[0]
                    }
                    let distance = this.calcDistanceBetweenPoints(point, point2)    
                    console.log(point.x, point.y, point2.x, point2.y, distance)
                    perimeter += distance
                })
                return perimeter / this.defaultRatio
            },
            calcDistanceBetweenPoints: function(p1, p2) {
                return Math.sqrt(Math.pow(p2.x - p1.x, 2) + Math.pow(p2.y - p2.y, 2))
            },
            drawPolygon: function() {
                this.polygonMode = true
            }
        }
    }

</script>

<style>
  canvas {
    margin-top: 42px;
    border: 1px solid red;
    display:block
 }
</style>
