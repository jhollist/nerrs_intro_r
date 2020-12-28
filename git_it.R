while(T){
  Sys.sleep(10)
  system("git add -A")
  system('git commit -m "auto commit"')
  system("git push origin main")
}