
import { motion } from "framer-motion";
import { ArrowRight, ChevronRight } from "lucide-react";
import { Button } from "@/components/ui/button";

const Index = () => {
  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-50 to-gray-100">
      <nav className="fixed w-full bg-white/80 backdrop-blur-lg border-b border-gray-100 z-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <div className="flex items-center">
              <span className="text-xl font-semibold">Baa Rabaa</span>
            </div>
            <div className="hidden md:block">
              <div className="flex items-center space-x-8">
                {['Products', 'Features', 'About', 'Contact'].map((item) => (
                  <a
                    key={item}
                    href={`#${item.toLowerCase()}`}
                    className="text-gray-600 hover:text-gray-900 transition-colors duration-200 text-sm font-medium"
                  >
                    {item}
                  </a>
                ))}
              </div>
            </div>
          </div>
        </div>
      </nav>

      <main>
        {/* Hero Section */}
        <section className="pt-32 pb-20 px-4 sm:px-6 lg:px-8">
          <div className="max-w-7xl mx-auto">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5 }}
              className="text-center"
            >
              <span className="inline-block px-4 py-1.5 mb-6 text-sm font-medium bg-gray-100 rounded-full text-gray-600">
                Introducing Baa Rabaa
              </span>
              <h1 className="text-4xl md:text-6xl font-bold text-gray-900 mb-6 leading-tight">
                Elegance through
                <br />
                <span className="text-gray-600">simplicity</span>
              </h1>
              <p className="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
                Experience design that speaks through its silence, where every detail serves a purpose.
              </p>
              <Button
                className="group inline-flex items-center space-x-2 bg-gray-900 hover:bg-gray-800 text-white px-6 py-3 rounded-full transition-all duration-200"
              >
                <span>Explore Now</span>
                <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform duration-200" />
              </Button>
            </motion.div>
          </div>
        </section>

        {/* Features Section */}
        <section className="py-20 px-4 sm:px-6 lg:px-8 bg-white">
          <div className="max-w-7xl mx-auto">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              {[
                {
                  title: 'Thoughtful Design',
                  description: 'Every element crafted with purpose and precision.',
                },
                {
                  title: 'Seamless Experience',
                  description: 'Intuitive interactions that feel natural and effortless.',
                },
                {
                  title: 'Timeless Appeal',
                  description: 'Beauty that transcends trends and remains relevant.',
                },
              ].map((feature, index) => (
                <motion.div
                  key={feature.title}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                  className="group p-8 bg-gray-50 rounded-2xl hover:bg-white hover:shadow-lg transition-all duration-300"
                >
                  <h3 className="text-xl font-semibold text-gray-900 mb-4">{feature.title}</h3>
                  <p className="text-gray-600 mb-4">{feature.description}</p>
                  <a
                    href="#"
                    className="inline-flex items-center text-sm font-medium text-gray-900 group-hover:translate-x-1 transition-transform duration-200"
                  >
                    Learn more
                    <ChevronRight className="ml-1 w-4 h-4" />
                  </a>
                </motion.div>
              ))}
            </div>
          </div>
        </section>
      </main>

      <footer className="bg-gray-50 border-t border-gray-100">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <div className="text-center">
            <p className="text-gray-600 text-sm">
              © 2024 Baa Rabaa. All rights reserved.
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default Index;
