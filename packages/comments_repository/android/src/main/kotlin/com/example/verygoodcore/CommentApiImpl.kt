package com.example.verygoodcore

import CommentApi
import CommentModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONArray
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

/**
 * Implementation of the Pigeon-generated CommentApi interface.
 *
 * This implementation fetches comments from a REST API using a base URL configuration.
 * It uses Kotlin coroutines to perform network calls on the IO dispatcher,
 * preventing network operations from running on the main thread.
 */
class CommentApiImpl : CommentApi {

  // Base URL configuration properties.
  private var scheme: String = "https"
  private var authority: String = "jsonplaceholder.typicode.com"
  private var port: Int = 443

  override fun setBaseUrl(scheme: String, authority: String, port: Long) {
    this.scheme = scheme
    this.authority = authority
    this.port = port.toInt()
  }

  /**
   * Asynchronously fetches comments for the given [postId].
   *
   * This method launches a coroutine on the IO dispatcher to perform the network
   * operations off the main thread and returns the result via the provided callback.
   *
   * @param postId The ID of the post whose comments should be fetched.
   * @param callback A callback that receives a [Result] wrapping a list of CommentModel objects
   *                 or an error if the operation fails.
   */
  override fun getComments(postId: Long, callback: (Result<List<CommentModel>>) -> Unit) {
    CoroutineScope(Dispatchers.IO).launch {
      try {
        // Build the URL based on the stored configuration.
        val urlString = if ((scheme == "http" && port == 80) || (scheme == "https" && port == 443)) {
          "$scheme://$authority/comments?postId=$postId"
        } else {
          "$scheme://$authority:$port/comments?postId=$postId"
        }
        val url = URL(urlString)
        val connection = url.openConnection() as HttpURLConnection
        try {
          connection.requestMethod = "GET"
          connection.connectTimeout = 10000
          connection.readTimeout = 10000

          if (connection.responseCode != HttpURLConnection.HTTP_OK) {
            throw Exception("HTTP error code: ${connection.responseCode}")
          }

          // Read the response.
          val streamReader = InputStreamReader(connection.inputStream)
          val reader = BufferedReader(streamReader)
          val responseBuilder = StringBuilder()
          var line: String? = reader.readLine()
          while (line != null) {
            responseBuilder.append(line)
            line = reader.readLine()
          }
          reader.close()
          val response = responseBuilder.toString()

          // Parse the JSON array.
          val jsonArray = JSONArray(response)
          val comments = mutableListOf<CommentModel>()
          for (i in 0 until jsonArray.length()) {
            val jsonObject = jsonArray.getJSONObject(i)
            // Create a new instance of CommentModel using its constructor.
            val comment = CommentModel(
              postId = jsonObject.optLong("postId"),
              id = jsonObject.optLong("id"),
              name = jsonObject.optString("name"),
              email = jsonObject.optString("email"),
              body = jsonObject.optString("body")
            )
            comments.add(comment)
          }

          // Switch back to the Main thread to invoke the callback.
          withContext(Dispatchers.Main) {
            callback(Result.success(comments))
          }
        } finally {
          connection.disconnect()
        }
      } catch (e: Exception) {
        // On error, deliver the exception back on the Main thread.
        withContext(Dispatchers.Main) {
          callback(Result.failure(e))
        }
      }
    }
  }
}
