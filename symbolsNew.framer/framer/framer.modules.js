require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"Symbol":[function(require,module,exports){
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

exports.createSymbol = function(layer) {
  var Temp;
  return Temp = (function(superClass) {
    extend(Temp, superClass);

    function Temp(options) {
      var child, i, j, len, len1, ref, ref1, subLayer;
      if (options == null) {
        options = {};
      }
      if (options.backgroundColor == null) {
        options.backgroundColor = layer.backgroundColor;
      }
      if (options.opacity == null) {
        options.opacity = layer.props.opacity;
      }
      if (options.borderWidth == null) {
        options.borderWidth = layer.props.borderWidth;
      }
      if (options.borderColor == null) {
        options.borderColor = layer.props.borderColor;
      }
      if (options.borderRadius == null) {
        options.borderRadius = layer.props.borderRadius;
      }
      if (options.shadowSpread == null) {
        options.shadowSpread = layer.props.shadowSpread;
      }
      if (options.shadowX == null) {
        options.shadowX = layer.props.shadowX;
      }
      if (options.shadowY == null) {
        options.shadowY = layer.props.shadowY;
      }
      if (options.shadowBlur == null) {
        options.shadowBlur = layer.props.shadowBlur;
      }
      if (options.shadowColor == null) {
        options.shadowColor = layer.props.shadowColor;
      }
      if (options.scale == null) {
        options.scale = layer.props.scale;
      }
      if (options.scaleX == null) {
        options.scaleX = layer.props.scaleX;
      }
      if (options.scaleY == null) {
        options.scaleY = layer.props.scaleY;
      }
      if (options.rotation == null) {
        options.rotation = layer.props.rotation;
      }
      if (options.rotationX == null) {
        options.rotationX = layer.props.rotationX;
      }
      if (options.rotationY == null) {
        options.rotationY = layer.props.rotationY;
      }
      if (options.originX == null) {
        options.originX = layer.props.originX;
      }
      if (options.originY == null) {
        options.originY = layer.props.originY;
      }
      if (options.skewX == null) {
        options.skewX = layer.props.skewX;
      }
      if (options.skewY == null) {
        options.skewY = layer.props.skewY;
      }
      if (options.x == null) {
        options.x = false;
      }
      if (options.y == null) {
        options.y = false;
      }
      Temp.__super__.constructor.call(this, options);
      this.props = layer.props;
      this.name = options.name;
      this.size = options.size;
      this.backgroundColor = options.backgroundColor;
      this.opacity = options.opacity;
      this.borderWidth = options.borderWidth;
      this.borderColor = options.borderColor;
      this.borderRadius = options.borderRadius;
      this.shadowSpread = options.shadowSpread;
      this.shadowX = options.shadowX;
      this.shadowY = options.shadowY;
      this.shadowBlur = options.shadowBlur;
      this.shadowColor = options.shadowColor;
      this.scale = options.scale;
      this.scaleX = options.scaleX;
      this.scaleY = options.scaleY;
      this.rotation = options.rotation;
      this.rotationX = options.rotationX;
      this.rotationY = options.rotationY;
      this.originX = options.originX;
      this.originY = options.originY;
      this.skewX = options.skewX;
      this.skewY = options.skewY;
      this.x = options.x;
      this.y = options.y;
      this.customProps = options.customProps;
      ref = layer.descendants;
      for (i = 0, len = ref.length; i < len; i++) {
        subLayer = ref[i];
        if (subLayer.children.length > 0) {
          this[subLayer.name] = new Layer;
          this[subLayer.name].props = subLayer.props;
          this[subLayer.name].name = subLayer.name;
          this[subLayer.name].parent = this;
          ref1 = subLayer.children;
          for (j = 0, len1 = ref1.length; j < len1; j++) {
            child = ref1[j];
            if (child.constructor.name === "TextLayer") {
              this[child.name] = new TextLayer;
              this[child.name].props = child.props;
              this[child.name].name = child.name;
              this[child.name].parent = this[subLayer.name];
              this[child.name].textAlign = child.props.styledTextOptions.alignment;
            } else {
              this[child.name] = new Layer;
              this[child.name].props = child.props;
              this[child.name].name = child.name;
              this[child.name].parent = this[subLayer.name];
            }
          }
        } else if (subLayer.parent === layer) {
          if (subLayer.constructor.name === "TextLayer") {
            this[subLayer.name] = new TextLayer;
            this[subLayer.name].props = subLayer.props;
            this[subLayer.name].name = subLayer.name;
            this[subLayer.name].parent = this;
            this[subLayer.name].textAlign = subLayer.props.styledTextOptions.alignment;
          } else {
            this[subLayer.name] = new Layer;
            this[subLayer.name].props = subLayer.props;
            this[subLayer.name].name = subLayer.name;
            this[subLayer.name].parent = this;
          }
        }
      }
      this.on(Events.StateSwitchStart, function(from, to) {
        var k, len2, ref2, results, templateBackup, textBackup;
        ref2 = this.subLayers;
        results = [];
        for (k = 0, len2 = ref2.length; k < len2; k++) {
          child = ref2[k];
          templateBackup = {};
          if (child.constructor.name === "TextLayer") {
            textBackup = child.text;
            if (Object.keys(child.template).length > 0) {
              templateBackup = child.template;
            }
          }
          child.stateSwitch(to);
          if (child.constructor.name === "TextLayer") {
            child.template = templateBackup;
            results.push(child.text = textBackup);
          } else {
            results.push(void 0);
          }
        }
        return results;
      });
    }

    Temp.prototype.addSymbolState = function(stateName, target) {
      var child, i, len, ref;
      this.states["" + stateName] = {
        backgroundColor: target.backgroundColor,
        opacity: target.props.opacity,
        borderWidth: target.props.borderWidth,
        borderColor: target.props.borderColor,
        borderRadius: target.props.borderRadius,
        shadowSpread: target.props.shadowSpread,
        shadowX: target.props.shadowX,
        shadowY: target.props.shadowY,
        shadowBlur: target.props.shadowBlur,
        shadowColor: target.props.shadowColor,
        scale: target.props.scale,
        scaleX: target.props.scaleX,
        scaleY: target.props.scaleY,
        rotation: target.props.rotation,
        rotationX: target.props.rotationX,
        rotationY: target.props.rotationY,
        originX: target.props.originX,
        originY: target.props.originY,
        skewX: target.props.skewX,
        skewY: target.props.skewY
      };
      ref = this.subLayers;
      for (i = 0, len = ref.length; i < len; i++) {
        child = ref[i];
        child.states["" + stateName] = target.childrenWithName(child.name)[0].states["default"];
      }
      return target.destroy();
    };

    layer.destroy();

    return Temp;

  })(Layer);
};


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uL21vZHVsZXMvU3ltYm9sLmNvZmZlZSIsIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiXSwic291cmNlc0NvbnRlbnQiOlsiZXhwb3J0cy5jcmVhdGVTeW1ib2wgPSAobGF5ZXIpIC0+XG4gIGNsYXNzIFRlbXAgZXh0ZW5kcyBMYXllclxuICAgIGNvbnN0cnVjdG9yOiAob3B0aW9ucz17fSkgLT5cbiAgICAgIG9wdGlvbnMuYmFja2dyb3VuZENvbG9yID89IGxheWVyLmJhY2tncm91bmRDb2xvclxuICAgICAgb3B0aW9ucy5vcGFjaXR5ID89IGxheWVyLnByb3BzLm9wYWNpdHlcbiAgICAgIG9wdGlvbnMuYm9yZGVyV2lkdGggPz0gbGF5ZXIucHJvcHMuYm9yZGVyV2lkdGhcbiAgICAgIG9wdGlvbnMuYm9yZGVyQ29sb3IgPz0gbGF5ZXIucHJvcHMuYm9yZGVyQ29sb3JcbiAgICAgIG9wdGlvbnMuYm9yZGVyUmFkaXVzID89IGxheWVyLnByb3BzLmJvcmRlclJhZGl1c1xuICAgICAgb3B0aW9ucy5zaGFkb3dTcHJlYWQgPz0gbGF5ZXIucHJvcHMuc2hhZG93U3ByZWFkXG4gICAgICBvcHRpb25zLnNoYWRvd1ggPz0gbGF5ZXIucHJvcHMuc2hhZG93WFxuICAgICAgb3B0aW9ucy5zaGFkb3dZID89IGxheWVyLnByb3BzLnNoYWRvd1lcbiAgICAgIG9wdGlvbnMuc2hhZG93Qmx1ciA/PSBsYXllci5wcm9wcy5zaGFkb3dCbHVyXG4gICAgICBvcHRpb25zLnNoYWRvd0NvbG9yID89IGxheWVyLnByb3BzLnNoYWRvd0NvbG9yXG4gICAgICBvcHRpb25zLnNjYWxlID89IGxheWVyLnByb3BzLnNjYWxlXG4gICAgICBvcHRpb25zLnNjYWxlWCA/PSBsYXllci5wcm9wcy5zY2FsZVhcbiAgICAgIG9wdGlvbnMuc2NhbGVZID89IGxheWVyLnByb3BzLnNjYWxlWVxuICAgICAgb3B0aW9ucy5yb3RhdGlvbiA/PSBsYXllci5wcm9wcy5yb3RhdGlvblxuICAgICAgb3B0aW9ucy5yb3RhdGlvblggPz0gbGF5ZXIucHJvcHMucm90YXRpb25YXG4gICAgICBvcHRpb25zLnJvdGF0aW9uWSA/PSBsYXllci5wcm9wcy5yb3RhdGlvbllcbiAgICAgIG9wdGlvbnMub3JpZ2luWCA/PSBsYXllci5wcm9wcy5vcmlnaW5YXG4gICAgICBvcHRpb25zLm9yaWdpblkgPz0gbGF5ZXIucHJvcHMub3JpZ2luWVxuICAgICAgb3B0aW9ucy5za2V3WCA/PSBsYXllci5wcm9wcy5za2V3WFxuICAgICAgb3B0aW9ucy5za2V3WSA/PSBsYXllci5wcm9wcy5za2V3WVxuXG4gICAgICBvcHRpb25zLnggPz0gZmFsc2VcbiAgICAgIG9wdGlvbnMueSA/PSBmYWxzZVxuXG4gICAgICBzdXBlciBvcHRpb25zXG5cbiAgICAgIEAucHJvcHMgPSBsYXllci5wcm9wc1xuXG4gICAgICBALm5hbWUgPSBvcHRpb25zLm5hbWVcbiAgICAgIEAuc2l6ZSA9IG9wdGlvbnMuc2l6ZVxuICAgICAgIyBALmltYWdlID0gb3B0aW9ucy5pbWFnZVxuICAgICAgQC5iYWNrZ3JvdW5kQ29sb3IgPSBvcHRpb25zLmJhY2tncm91bmRDb2xvclxuICAgICAgQC5vcGFjaXR5ID0gb3B0aW9ucy5vcGFjaXR5XG4gICAgICBALmJvcmRlcldpZHRoID0gb3B0aW9ucy5ib3JkZXJXaWR0aFxuICAgICAgQC5ib3JkZXJDb2xvciA9IG9wdGlvbnMuYm9yZGVyQ29sb3JcbiAgICAgIEAuYm9yZGVyUmFkaXVzID0gb3B0aW9ucy5ib3JkZXJSYWRpdXNcbiAgICAgIEAuc2hhZG93U3ByZWFkID0gb3B0aW9ucy5zaGFkb3dTcHJlYWRcbiAgICAgIEAuc2hhZG93WCA9IG9wdGlvbnMuc2hhZG93WFxuICAgICAgQC5zaGFkb3dZID0gb3B0aW9ucy5zaGFkb3dZXG4gICAgICBALnNoYWRvd0JsdXIgPSBvcHRpb25zLnNoYWRvd0JsdXJcbiAgICAgIEAuc2hhZG93Q29sb3IgPSBvcHRpb25zLnNoYWRvd0NvbG9yXG4gICAgICBALnNjYWxlID0gb3B0aW9ucy5zY2FsZVxuICAgICAgQC5zY2FsZVggPSBvcHRpb25zLnNjYWxlWFxuICAgICAgQC5zY2FsZVkgPSBvcHRpb25zLnNjYWxlWVxuICAgICAgQC5yb3RhdGlvbiA9IG9wdGlvbnMucm90YXRpb25cbiAgICAgIEAucm90YXRpb25YID0gb3B0aW9ucy5yb3RhdGlvblhcbiAgICAgIEAucm90YXRpb25ZID0gb3B0aW9ucy5yb3RhdGlvbllcbiAgICAgIEAub3JpZ2luWCA9IG9wdGlvbnMub3JpZ2luWFxuICAgICAgQC5vcmlnaW5ZID0gb3B0aW9ucy5vcmlnaW5ZXG4gICAgICBALnNrZXdYID0gb3B0aW9ucy5za2V3WFxuICAgICAgQC5za2V3WSA9IG9wdGlvbnMuc2tld1lcblxuICAgICAgQC54ID0gb3B0aW9ucy54XG4gICAgICBALnkgPSBvcHRpb25zLnlcblxuICAgICAgQC5jdXN0b21Qcm9wcyA9IG9wdGlvbnMuY3VzdG9tUHJvcHNcblxuICAgICAgZm9yIHN1YkxheWVyIGluIGxheWVyLmRlc2NlbmRhbnRzXG4gICAgICAgIGlmIHN1YkxheWVyLmNoaWxkcmVuLmxlbmd0aCA+IDBcbiAgICAgICAgICBAW3N1YkxheWVyLm5hbWVdID0gbmV3IExheWVyXG4gICAgICAgICAgQFtzdWJMYXllci5uYW1lXS5wcm9wcyA9IHN1YkxheWVyLnByb3BzXG4gICAgICAgICAgQFtzdWJMYXllci5uYW1lXS5uYW1lID0gc3ViTGF5ZXIubmFtZVxuICAgICAgICAgIEBbc3ViTGF5ZXIubmFtZV0ucGFyZW50ID0gQFxuICAgICAgICAgIGZvciBjaGlsZCBpbiBzdWJMYXllci5jaGlsZHJlblxuICAgICAgICAgICAgaWYgY2hpbGQuY29uc3RydWN0b3IubmFtZSA9PSBcIlRleHRMYXllclwiXG4gICAgICAgICAgICAgIEBbY2hpbGQubmFtZV0gPSBuZXcgVGV4dExheWVyXG5cbiAgICAgICAgICAgICAgQFtjaGlsZC5uYW1lXS5wcm9wcyA9IGNoaWxkLnByb3BzXG4gICAgICAgICAgICAgIEBbY2hpbGQubmFtZV0ubmFtZSA9IGNoaWxkLm5hbWVcbiAgICAgICAgICAgICAgQFtjaGlsZC5uYW1lXS5wYXJlbnQgPSBAW3N1YkxheWVyLm5hbWVdXG4gICAgICAgICAgICAgIEBbY2hpbGQubmFtZV0udGV4dEFsaWduID0gY2hpbGQucHJvcHMuc3R5bGVkVGV4dE9wdGlvbnMuYWxpZ25tZW50XG4gICAgICAgICAgICBlbHNlXG4gICAgICAgICAgICAgIEBbY2hpbGQubmFtZV0gPSBuZXcgTGF5ZXJcblxuICAgICAgICAgICAgICBAW2NoaWxkLm5hbWVdLnByb3BzID0gY2hpbGQucHJvcHNcbiAgICAgICAgICAgICAgQFtjaGlsZC5uYW1lXS5uYW1lID0gY2hpbGQubmFtZVxuICAgICAgICAgICAgICBAW2NoaWxkLm5hbWVdLnBhcmVudCA9IEBbc3ViTGF5ZXIubmFtZV1cbiAgICAgICAgZWxzZSBpZiBzdWJMYXllci5wYXJlbnQgaXMgbGF5ZXJcbiAgICAgICAgICBpZiBzdWJMYXllci5jb25zdHJ1Y3Rvci5uYW1lID09IFwiVGV4dExheWVyXCJcbiAgICAgICAgICAgIEBbc3ViTGF5ZXIubmFtZV0gPSBuZXcgVGV4dExheWVyXG5cbiAgICAgICAgICAgIEBbc3ViTGF5ZXIubmFtZV0ucHJvcHMgPSBzdWJMYXllci5wcm9wc1xuICAgICAgICAgICAgQFtzdWJMYXllci5uYW1lXS5uYW1lID0gc3ViTGF5ZXIubmFtZVxuICAgICAgICAgICAgQFtzdWJMYXllci5uYW1lXS5wYXJlbnQgPSBAXG4gICAgICAgICAgICBAW3N1YkxheWVyLm5hbWVdLnRleHRBbGlnbiA9IHN1YkxheWVyLnByb3BzLnN0eWxlZFRleHRPcHRpb25zLmFsaWdubWVudFxuICAgICAgICAgIGVsc2VcbiAgICAgICAgICAgIEBbc3ViTGF5ZXIubmFtZV0gPSBuZXcgTGF5ZXJcblxuICAgICAgICAgICAgQFtzdWJMYXllci5uYW1lXS5wcm9wcyA9IHN1YkxheWVyLnByb3BzXG4gICAgICAgICAgICBAW3N1YkxheWVyLm5hbWVdLm5hbWUgPSBzdWJMYXllci5uYW1lXG4gICAgICAgICAgICBAW3N1YkxheWVyLm5hbWVdLnBhcmVudCA9IEBcblxuICAgICAgQC5vbiBFdmVudHMuU3RhdGVTd2l0Y2hTdGFydCwgKGZyb20sIHRvKSAtPlxuICAgICAgICBmb3IgY2hpbGQgaW4gQC5zdWJMYXllcnNcbiAgICAgICAgICB0ZW1wbGF0ZUJhY2t1cCA9IHt9XG4gICAgICAgICAgaWYgY2hpbGQuY29uc3RydWN0b3IubmFtZSA9PSBcIlRleHRMYXllclwiXG4gICAgICAgICAgICB0ZXh0QmFja3VwID0gY2hpbGQudGV4dFxuXG4gICAgICAgICAgICBpZiBPYmplY3Qua2V5cyhjaGlsZC50ZW1wbGF0ZSkubGVuZ3RoID4gMFxuICAgICAgICAgICAgICB0ZW1wbGF0ZUJhY2t1cCA9IGNoaWxkLnRlbXBsYXRlXG5cbiAgICAgICAgICAjIGNoaWxkLnN0YXRlQ3ljbGUodG8pXG4gICAgICAgICAgY2hpbGQuc3RhdGVTd2l0Y2godG8pXG5cbiAgICAgICMgQC5vbiBFdmVudHMuQW5pbWF0aW9uRW5kLCAoYW5pbWF0aW9uLCBsYXllcikgLT5cbiAgICAgICAgIyBwcmludCBhbmltYXRpb24sIGxheWVyXG4gICAgICAgICAgaWYgY2hpbGQuY29uc3RydWN0b3IubmFtZSA9PSBcIlRleHRMYXllclwiXG4gICAgICAgICAgICBjaGlsZC50ZW1wbGF0ZSA9IHRlbXBsYXRlQmFja3VwXG4gICAgICAgICAgICBjaGlsZC50ZXh0ID0gdGV4dEJhY2t1cFxuXG4gICAgYWRkU3ltYm9sU3RhdGU6IChzdGF0ZU5hbWUsIHRhcmdldCkgLT5cbiAgICAgIEAuc3RhdGVzW1wiI3tzdGF0ZU5hbWV9XCJdID1cbiAgICAgICAgICBiYWNrZ3JvdW5kQ29sb3I6IHRhcmdldC5iYWNrZ3JvdW5kQ29sb3JcbiAgICAgICAgICBvcGFjaXR5OiB0YXJnZXQucHJvcHMub3BhY2l0eVxuICAgICAgICAgIGJvcmRlcldpZHRoOiB0YXJnZXQucHJvcHMuYm9yZGVyV2lkdGhcbiAgICAgICAgICBib3JkZXJDb2xvcjogdGFyZ2V0LnByb3BzLmJvcmRlckNvbG9yXG4gICAgICAgICAgYm9yZGVyUmFkaXVzOiB0YXJnZXQucHJvcHMuYm9yZGVyUmFkaXVzXG4gICAgICAgICAgc2hhZG93U3ByZWFkOiB0YXJnZXQucHJvcHMuc2hhZG93U3ByZWFkXG4gICAgICAgICAgc2hhZG93WDogdGFyZ2V0LnByb3BzLnNoYWRvd1hcbiAgICAgICAgICBzaGFkb3dZOiB0YXJnZXQucHJvcHMuc2hhZG93WVxuICAgICAgICAgIHNoYWRvd0JsdXI6IHRhcmdldC5wcm9wcy5zaGFkb3dCbHVyXG4gICAgICAgICAgc2hhZG93Q29sb3I6IHRhcmdldC5wcm9wcy5zaGFkb3dDb2xvclxuICAgICAgICAgIHNjYWxlOiB0YXJnZXQucHJvcHMuc2NhbGVcbiAgICAgICAgICBzY2FsZVg6IHRhcmdldC5wcm9wcy5zY2FsZVhcbiAgICAgICAgICBzY2FsZVk6IHRhcmdldC5wcm9wcy5zY2FsZVlcbiAgICAgICAgICByb3RhdGlvbjogdGFyZ2V0LnByb3BzLnJvdGF0aW9uXG4gICAgICAgICAgcm90YXRpb25YOiB0YXJnZXQucHJvcHMucm90YXRpb25YXG4gICAgICAgICAgcm90YXRpb25ZOiB0YXJnZXQucHJvcHMucm90YXRpb25ZXG4gICAgICAgICAgb3JpZ2luWDogdGFyZ2V0LnByb3BzLm9yaWdpblhcbiAgICAgICAgICBvcmlnaW5ZOiB0YXJnZXQucHJvcHMub3JpZ2luWVxuICAgICAgICAgIHNrZXdYOiB0YXJnZXQucHJvcHMuc2tld1hcbiAgICAgICAgICBza2V3WTogdGFyZ2V0LnByb3BzLnNrZXdZXG5cbiAgICAgIGZvciBjaGlsZCBpbiBALnN1YkxheWVyc1xuICAgICAgICBjaGlsZC5zdGF0ZXNbXCIje3N0YXRlTmFtZX1cIl0gPSB0YXJnZXQuY2hpbGRyZW5XaXRoTmFtZShjaGlsZC5uYW1lKVswXS5zdGF0ZXNbXCJkZWZhdWx0XCJdXG4gICAgICAgICAgIyBiYWNrZ3JvdW5kQ29sb3I6IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLmJhY2tncm91bmRDb2xvclxuICAgICAgICAgICMgb3BhY2l0eTogdGFyZ2V0LmNoaWxkcmVuV2l0aE5hbWUoY2hpbGQubmFtZSkucHJvcHMub3BhY2l0eVxuICAgICAgICAgICMgYm9yZGVyV2lkdGg6IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLnByb3BzLmJvcmRlcldpZHRoXG4gICAgICAgICAgIyBib3JkZXJDb2xvcjogdGFyZ2V0LmNoaWxkcmVuV2l0aE5hbWUoY2hpbGQubmFtZSkucHJvcHMuYm9yZGVyQ29sb3JcbiAgICAgICAgICAjIGJvcmRlclJhZGl1czogdGFyZ2V0LmNoaWxkcmVuV2l0aE5hbWUoY2hpbGQubmFtZSkucHJvcHMuYm9yZGVyUmFkaXVzXG4gICAgICAgICAgIyBzaGFkb3dTcHJlYWQ6IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLnByb3BzLnNoYWRvd1NwcmVhZFxuICAgICAgICAgICMgc2hhZG93WDogdGFyZ2V0LmNoaWxkcmVuV2l0aE5hbWUoY2hpbGQubmFtZSkucHJvcHMuc2hhZG93WFxuICAgICAgICAgICMgc2hhZG93WTogdGFyZ2V0LmNoaWxkcmVuV2l0aE5hbWUoY2hpbGQubmFtZSkucHJvcHMuc2hhZG93WVxuICAgICAgICAgICMgc2hhZG93Qmx1cjogdGFyZ2V0LmNoaWxkcmVuV2l0aE5hbWUoY2hpbGQubmFtZSkucHJvcHMuc2hhZG93Qmx1clxuICAgICAgICAgICMgc2hhZG93Q29sb3I6IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLnByb3BzLnNoYWRvd0NvbG9yXG4gICAgICAgICAgIyBzY2FsZTogdGFyZ2V0LmNoaWxkcmVuV2l0aE5hbWUoY2hpbGQubmFtZSkucHJvcHMuc2NhbGVcbiAgICAgICAgICAjIHNjYWxlWDogdGFyZ2V0LmNoaWxkcmVuV2l0aE5hbWUoY2hpbGQubmFtZSkucHJvcHMuc2NhbGVYXG4gICAgICAgICAgIyBzY2FsZVk6IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLnByb3BzLnNjYWxlWVxuICAgICAgICAgICMgcm90YXRpb246IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLnByb3BzLnJvdGF0aW9uXG4gICAgICAgICAgIyByb3RhdGlvblg6IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLnByb3BzLnJvdGF0aW9uWFxuICAgICAgICAgICMgcm90YXRpb25ZOiB0YXJnZXQuY2hpbGRyZW5XaXRoTmFtZShjaGlsZC5uYW1lKS5wcm9wcy5yb3RhdGlvbllcbiAgICAgICAgICAjIG9yaWdpblg6IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLnByb3BzLm9yaWdpblhcbiAgICAgICAgICAjIG9yaWdpblk6IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLnByb3BzLm9yaWdpbllcbiAgICAgICAgICAjIHNrZXdYOiB0YXJnZXQuY2hpbGRyZW5XaXRoTmFtZShjaGlsZC5uYW1lKS5wcm9wcy5za2V3WFxuICAgICAgICAgICMgc2tld1k6IHRhcmdldC5jaGlsZHJlbldpdGhOYW1lKGNoaWxkLm5hbWUpLnByb3BzLnNrZXdZXG5cbiAgICAgIHRhcmdldC5kZXN0cm95KClcblxuICAgIGxheWVyLmRlc3Ryb3koKVxuIiwiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFDQUE7QURBQSxJQUFBOzs7QUFBQSxPQUFPLENBQUMsWUFBUixHQUF1QixTQUFDLEtBQUQ7QUFDckIsTUFBQTtTQUFNOzs7SUFDUyxjQUFDLE9BQUQ7QUFDWCxVQUFBOztRQURZLFVBQVE7OztRQUNwQixPQUFPLENBQUMsa0JBQW1CLEtBQUssQ0FBQzs7O1FBQ2pDLE9BQU8sQ0FBQyxVQUFXLEtBQUssQ0FBQyxLQUFLLENBQUM7OztRQUMvQixPQUFPLENBQUMsY0FBZSxLQUFLLENBQUMsS0FBSyxDQUFDOzs7UUFDbkMsT0FBTyxDQUFDLGNBQWUsS0FBSyxDQUFDLEtBQUssQ0FBQzs7O1FBQ25DLE9BQU8sQ0FBQyxlQUFnQixLQUFLLENBQUMsS0FBSyxDQUFDOzs7UUFDcEMsT0FBTyxDQUFDLGVBQWdCLEtBQUssQ0FBQyxLQUFLLENBQUM7OztRQUNwQyxPQUFPLENBQUMsVUFBVyxLQUFLLENBQUMsS0FBSyxDQUFDOzs7UUFDL0IsT0FBTyxDQUFDLFVBQVcsS0FBSyxDQUFDLEtBQUssQ0FBQzs7O1FBQy9CLE9BQU8sQ0FBQyxhQUFjLEtBQUssQ0FBQyxLQUFLLENBQUM7OztRQUNsQyxPQUFPLENBQUMsY0FBZSxLQUFLLENBQUMsS0FBSyxDQUFDOzs7UUFDbkMsT0FBTyxDQUFDLFFBQVMsS0FBSyxDQUFDLEtBQUssQ0FBQzs7O1FBQzdCLE9BQU8sQ0FBQyxTQUFVLEtBQUssQ0FBQyxLQUFLLENBQUM7OztRQUM5QixPQUFPLENBQUMsU0FBVSxLQUFLLENBQUMsS0FBSyxDQUFDOzs7UUFDOUIsT0FBTyxDQUFD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
