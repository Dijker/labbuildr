## install-ecs3
the new ecs3 installer uses labbuildr new-lab-vmx and set-labcentosvmx cmdlets to use a streamlined deployment of the operatin system.
also, the new ecs installer is used, using ansible and a containerized installation method

a new ecs single node deployment is started with
```Powershell
.\install-ecs3.ps1 
```

if no operating system master for centos is found, it will be downloaded automatically from labbuildr repo on azure
![image](https://cloud.githubusercontent.com/assets/8255007/26436602/f7aa38a2-4117-11e7-917d-efd6bb8eb420.png)
enter y to start download 
![image](https://cloud.githubusercontent.com/assets/8255007/26436636/2ad2eaf8-4118-11e7-9168-ec36d30fdcd3.png)
after the master is downloaded, a base snap is created.  

a linked clone is than created a and customized. ( -fullclone create a full clone )
during customization, 3 disks, 16GB and 4CPU are added.

to speed up installation time, the containerimage for ecs will always be stored on the labbuildr sources preserving the image tag. specific images can be selected from istall-ecs3


once all seetings are done, the bootsrap process for ecs is done.
![image](https://cloud.githubusercontent.com/assets/8255007/26436902/251a4fe6-411a-11e7-9354-d9376a09606a.png)
after the bootstrap and injecting a customized deploy.yaml file, ecs node will reboot.
you can follow the progress of the bootstrap on ecsnode1 by doing 
```
tail -f /ECS-CommunityEdition/install.log
```

![image](https://cloud.githubusercontent.com/assets/8255007/26437099/5d89315c-411b-11e7-8627-83539cb3d065.png)

after reboot, step1 will start once docker service is up and running

![image](https://cloud.githubusercontent.com/assets/8255007/26437184/d22ceaa8-411b-11e7-9591-d7cce6c61f4c.png)

you can monitor step1 by 
```
tail -f /tmp/systemd-private-*-vmtoolsd.service-*/tmp/labbuildr.log
```
![image](https://cloud.githubusercontent.com/assets/8255007/26437939/4ae4c232-4120-11e7-8baf-67b4be6880fd.png)


once step1 is finished, step2 starts automatically.
you can monitor step2 by 
```
tail -f /tmp/systemd-private-*-vmtoolsd.service-*/tmp/labbuildr.log
```

![image](https://cloud.githubusercontent.com/assets/8255007/26439048/9f273b80-4126-11e7-8720-4a4aebc41679.png)

once finished, the deploymenttimes will be displayed for each step.
![image](https://cloud.githubusercontent.com/assets/8255007/26439527/e5d67db4-4128-11e7-9365-68f25563cebd.png)

you can now login to your ecs instance with root / changeme.
follow the instructions of the wizard


![image](https://cloud.githubusercontent.com/assets/8255007/26439615/3b259ba6-4129-11e7-9c28-228e37dcec44.png)


![image](https://cloud.githubusercontent.com/assets/8255007/26439713/8b6e2bc8-4129-11e7-8f9a-d6f657053a0c.png)




custom parameters can be specified, see get-help install-ecs3.ps1


once the node is booted, the system is running the network configuration of the node
