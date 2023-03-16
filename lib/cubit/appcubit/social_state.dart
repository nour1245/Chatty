abstract class SocialStates {}

class SocialInitial extends SocialStates {}

class UserLoadingState extends SocialStates {}

class UserSuccessState extends SocialStates {}

class UserErrorState extends SocialStates {
  final String? error;

  UserErrorState(this.error);
}

class BottomNavBarChange extends SocialStates {}

class NewPostState extends SocialStates {}

class EditProfileImageSuccessState extends SocialStates {}

class EditProfileImageErrorState extends SocialStates {}

class EditCoverImageSuccessState extends SocialStates {}

class EditCoverImageErrorState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageLoadingState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageLoadingState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

class UserUpdateError extends SocialStates {}

class UserUpdateLoading extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostLoadingState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

class PostImageSuccessState extends SocialStates {}

class PostImageErrorState extends SocialStates {}

class RemovePostImage extends SocialStates {}

class PostsLoadingState extends SocialStates {}

class PostsSuccessState extends SocialStates {}

class PostsErrorState extends SocialStates {
  final String? error;

  PostsErrorState(this.error);
}

class PostsLikesLoadingState extends SocialStates {}

class PostsLikesSuccessState extends SocialStates {}

class PostsLikesErrorState extends SocialStates {
  final String? error;

  PostsLikesErrorState(this.error);
}

class AllUsersLoadingState extends SocialStates {}

class AllUsersSuccessState extends SocialStates {}

class AllUsersErrorState extends SocialStates {
  final String? error;

  AllUsersErrorState(this.error);
}

class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {
  final String? error;

  SendMessageErrorState(this.error);
}

class GetMessageSuccessState extends SocialStates {}

class PostsCommentsLoadingState extends SocialStates {}

class PostsCommentsSuccessState extends SocialStates {}

class PostsCommentsErrorState extends SocialStates {
  final String? error;

  PostsCommentsErrorState(this.error);
}

class PostsDeleteSuccessState extends SocialStates {}

class PostsDeleteErrorState extends SocialStates {
  final String? error;

  PostsDeleteErrorState(this.error);
}

class EditPhotoSuccessState extends SocialStates{}
class EditPhotoErrorState extends SocialStates{}


class UploadPhotoLoadingState extends SocialStates{}
class UploadPhotoErrorState extends SocialStates{}
class UploadPhotoSuccessState extends SocialStates{}

class DeletePhotoSuccess extends SocialStates{}
class DeletePhotoLoading extends SocialStates{}