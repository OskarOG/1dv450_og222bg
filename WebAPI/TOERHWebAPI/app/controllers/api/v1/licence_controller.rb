class Api::V1::LicenceController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/licence?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def index
		licences = Licence.all
		if licences != nil
			resultHash = Hash.new
			resultArray = Array.new
			licences.each do |licence|
				resultArray<<generateLicenceHash(licence)
			end
			resultHash["status"]=200
			resultHash["licences"]=resultArray
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no licences"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# GET: api/v1/licence/:id?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def show
		begin
			licence = Licence.find(params[:id])
			resultArray = Array.new
			resultHash = Hash.new
			licence.resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			resultHash["status"]=200
			resultHash["licenceid"]=generateLicenceHash(licence)
			resultHash["resources"]=resultArray
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		rescue
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no such licence"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
end