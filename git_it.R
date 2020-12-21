while(T){
  Sys.sleep(1)
  system("git add -A")
  system('git commit -m "auto commit"')
  system("git push origin main")
}