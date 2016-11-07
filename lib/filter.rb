require 'fft'

class ButterworthFilter

	def initialize(image_matrix)
		@image_matrix = image_matrix
		@rows = image_matrix.size
		@columns = image_matrix[0].size
		@row_split = @rows / 2 
		@col_split = @col / 2 
	end

	def to_frequency_domain
		auxiliary_matrix = @image_matrix.fft
		return auxiliary_matrix
	end

	def to_spacial_domain(smoothened_matrix)
		final_matrix = smoothened_matrix.rfft
		return final_matrix
	end

	def low_pass_filter(n, cutoff_frequency, epsilon=1)
		processed_matrix = self.to_frequency_domain
		for i in 0..@rows
			for j in 0..@columns
				omega = Math.sqrt((i - @row_split)**2 + (j - @col_split)**2)
				base = 1 + epsilon * ((omega / cutoff_frequency) ** (2 * n))
				processed_matrix[i][j] *= 1 / base
			end
		end
		filtered_matrix = self.to_spacial_domain(processed_matrix)
		return filtered_matrix
	end

	def high_pass_filter(n, cutoff_frequency, epsilon=1)
		processed_matrix = self.to_frequency_domain
		for i in 0..@rows
			for j in 0..@columns
				omega = Math.sqrt((i - @row_split)**2 + (j - @col_split)**2)
				base = 1 + epsilon * ((omega / cutoff_frequency) ** (2 * n))
				processed_matrix[i][j] *= 1 - (1 / base)
			end
		end
		filtered_matrix = self.to_spacial_domain(processed_matrix)
		return filtered_matrix
	end
end