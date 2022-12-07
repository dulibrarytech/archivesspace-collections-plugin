ArchivesSpacePublic::Application.routes.draw do
  scope AppConfig[:public_prefix] do
    match('/collections' => 'collections#index', :via => [:get])
  end
end
