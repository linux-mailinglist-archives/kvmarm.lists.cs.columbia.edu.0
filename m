Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C040580C
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 15:54:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F0E664B16E;
	Thu,  9 Sep 2021 09:54:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDW2RH8e+lJT; Thu,  9 Sep 2021 09:54:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8ADC14B15E;
	Thu,  9 Sep 2021 09:54:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 23CB84B159
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 09:54:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJLEwxtvh5dP for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Sep 2021 09:54:34 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 842E04B156
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 09:54:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631195674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEVPyarOdAG4+QXV2M6pVKkXfZcNCBW8zpMaROhMu5s=;
 b=KcmKU3yfWfDiu90ZDOFR/Q5fh37yT0rhx7tWv8fVInoiNVLLUcmWmw8RfmNz1vH+FwruEs
 2ddB5eKDw7lHA9rmTz7QXxPiRYFsBVHGQzdV+Q4U2H0pvGoE8LHZq7t5dgmg6Nh8HltlWt
 dsbkDwpyqNE6SqXV3oqfffA5uBnHxpk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-4k-VHFiqOQKaURPuSjZ57A-1; Thu, 09 Sep 2021 09:54:33 -0400
X-MC-Unique: 4k-VHFiqOQKaURPuSjZ57A-1
Received: by mail-wm1-f72.google.com with SMTP id
 p11-20020a05600c204b00b002f05aff1663so757755wmg.2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 09 Sep 2021 06:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wEVPyarOdAG4+QXV2M6pVKkXfZcNCBW8zpMaROhMu5s=;
 b=dup/V5+OnVyD2BhbVS9jFJzHmmdJtgbHiBNES4yOtYxZhSCEOpSe3/C7Cg/pxfufhx
 nrXWRfJUAmEM4Uqqv16b+czE0rdf8MCSu4IVhd2GhN0KW2xQzHh0WN+Ca4pd53RbLsL3
 ibA3uzLPte5kTQR+UoqrWg7F6kKc13pk3EBOZ8mVN58JLT3PcFwaOmdGnMMy/ui80onJ
 m4Fbc6ngEFcoLsOhCzOZogdi+eA0j/OUM8zaXCpfWSr6jcqEyUDwXk1ZWOXEyCGzAXg1
 9QCL1RHrU+xR5CIGBn+1nnhtrkpJ38DwVrFCjWYzRKMLZ8VS97aCrX4Lfd6OLxLUa84F
 YCNg==
X-Gm-Message-State: AOAM531FV3Ad6Oeur+ipV83/TR7jFoUrP1kbsgelTvMEv/PMDTpT+8rS
 cycV2ZY+sxjmfo+bUrGYdSloZ+KoP0943TzhtI6lpKnF2PgWGoSuV5Pceo0qTANdsW58GwHV1q/
 x6OR3ayLJodlwxo4DbMzf6SHj
X-Received: by 2002:a05:6000:1c4:: with SMTP id
 t4mr3745773wrx.414.1631195671781; 
 Thu, 09 Sep 2021 06:54:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzENPh15kgj7b+ORGo05x4NaTJWILlsrcu/90V3+5zY1byaTVnSKjHqkZXMU3GGjMJN9Xaaqw==
X-Received: by 2002:a05:6000:1c4:: with SMTP id
 t4mr3745747wrx.414.1631195671555; 
 Thu, 09 Sep 2021 06:54:31 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id v12sm1885544wrm.7.2021.09.09.06.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 06:54:31 -0700 (PDT)
Date: Thu, 9 Sep 2021 15:54:29 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [kvm-unit-tests RFC PATCH 4/5] scripts: Generate kvmtool
 standalone tests
Message-ID: <20210909135429.dqreodxr7elpvmfm@gator>
References: <20210702163122.96110-1-alexandru.elisei@arm.com>
 <20210702163122.96110-5-alexandru.elisei@arm.com>
 <20210907102135.i2w3r7j4zyj736b5@gator>
 <ee11a10a-c3e6-b9ce-81e1-147025a9b5bd@arm.com>
 <20210908160743.l4hrl4de7wkxwuda@gator>
 <9d5da497-7070-31ef-282a-a11a86e0102e@arm.com>
 <20210909130553.gnzce7cs7d5stvjd@gator>
 <7313396e-de46-8a3b-902d-5a59b2089c79@arm.com>
MIME-Version: 1.0
In-Reply-To: <7313396e-de46-8a3b-902d-5a59b2089c79@arm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, linux-s390@vger.kernel.org, thuth@redhat.com,
 frankja@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com,
 andre.przywara@arm.com, cohuck@redhat.com, kvm-ppc@vger.kernel.org,
 vivek.gautam@arm.com, maz@kernel.org, pbonzini@redhat.com,
 imbrenda@linux.ibm.com, kvmarm@lists.cs.columbia.edu
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Sep 09, 2021 at 02:47:57PM +0100, Alexandru Elisei wrote:
> Hi Drew,
> 
> On 9/9/21 2:05 PM, Andrew Jones wrote:
> > On Thu, Sep 09, 2021 at 12:11:52PM +0100, Alexandru Elisei wrote:
> >> Hi Drew,
> >>
> >> On 9/8/21 5:07 PM, Andrew Jones wrote:
> >>> On Wed, Sep 08, 2021 at 04:37:39PM +0100, Alexandru Elisei wrote:
> >>>> Hi Drew,
> >>>>
> >>>> On 9/7/21 11:21 AM, Andrew Jones wrote:
> >>>>> On Fri, Jul 02, 2021 at 05:31:21PM +0100, Alexandru Elisei wrote:
> >>>>>> Add support for the standalone target when running kvm-unit-tests under
> >>>>>> kvmtool.
> >>>>>>
> >>>>>> Example command line invocation:
> >>>>>>
> >>>>>> $ ./configure --target=kvmtool
> >>>>>> $ make clean && make standalone
> >>>>>>
> >>>>>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> >>>>>> ---
> >>>>>>  scripts/mkstandalone.sh | 14 +++++++-------
> >>>>>>  1 file changed, 7 insertions(+), 7 deletions(-)
> >>>>>>
> >>>>>> diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
> >>>>>> index 16f461c06842..d84bdb7e278c 100755
> >>>>>> --- a/scripts/mkstandalone.sh
> >>>>>> +++ b/scripts/mkstandalone.sh
> >>>>>> @@ -44,6 +44,10 @@ generate_test ()
> >>>>>>  	config_export ARCH_NAME
> >>>>>>  	config_export PROCESSOR
> >>>>>>  
> >>>>>> +	if [ "$ARCH" = "arm64" ] || [ "$ARCH" = "arm" ]; then
> >>>>>> +		config_export TARGET
> >>>>>> +	fi
> >>>>> Should export unconditionally, since we'll want TARGET set
> >>>>> unconditionally.
> >>>> Yes, will do.
> >>>>
> >>>>>> +
> >>>>>>  	echo "echo BUILD_HEAD=$(cat build-head)"
> >>>>>>  
> >>>>>>  	if [ ! -f $kernel ]; then
> >>>>>> @@ -59,7 +63,7 @@ generate_test ()
> >>>>>>  		echo 'export FIRMWARE'
> >>>>>>  	fi
> >>>>>>  
> >>>>>> -	if [ "$ENVIRON_DEFAULT" = "yes" ] && [ "$ERRATATXT" ]; then
> >>>>>> +	if [ "$TARGET" != "kvmtool" ] && [ "$ENVIRON_DEFAULT" = "yes" ] && [ "$ERRATATXT" ]; then
> >>>>> I think it would be better to ensure that ENVIRON_DEFAULT is "no" for
> >>>>> TARGET=kvmtool in configure.
> >>>> From looking at the code, it is my understanding that with ENVIRON_DEFAULT=yes, an
> >>>> initrd file is generated with the contents of erratatxt and other information, in
> >>>> a key=value pair format. This initrd is then passed on to the test (please correct
> >>>> me if I'm wrong). With ENVIRON_DEFAULT=no (set via ./configure
> >>>> --disable-default-environ), this initrd is not generated.
> >>>>
> >>>> kvmtool doesn't have support for passing an initrd when loading firmware, so yes,
> >>>> I believe the default should be no.
> >>>>
> >>>> However, I have two questions:
> >>>>
> >>>> 1. What happens when the user specifically enables the default environ via
> >>>> ./configure --enable-default-environ --target=kvmtool? In my opinion, that should
> >>>> be an error because the user wants something that is not possible with kvmtool
> >>>> (loading an image with --firmware in kvmtool means that the initrd image it not
> >>>> loaded into the guest memory and no node is generated for it in the dtb), but I
> >>>> would like to hear your thoughts about it.
> >>> As part of the forcing ENVIRON_DEFAULT to "no" for kvmtool in configure an
> >>> error should be generated if a user tries to explicitly enable it.
> >>>
> >>>> 2. If the default environment is disabled, is it still possible for an user to
> >>>> pass an initrd via other means? I couldn't find where that is implemented, so I'm
> >>>> guessing it's not possible.
> >>> Yes, a user could have a KVM_UNIT_TESTS_ENV environment variable set when
> >>> they launch the tests. If that variable points to a file then it will get
> >>> passed as an initrd. I guess you should also report a warning in arm/run
> >>> if KVM_UNIT_TESTS_ENV is set which states that the environment file will
> >>> be ignored when running with kvmtool.
> >> Thank you for explaining it, I had looked at
> >> scripts/arch-run.bash::initrd_create(), but it didn't click that setting the
> >> KVM_UNIT_TESTS_ENV environment variable is enough to generate and use the initrd.
> >>
> >> After looking at the code some more, in the logs the -initrd argument is shown as
> >> a comment, instead of an actual argument that is passed to qemu:
> >>
> >> timeout -k 1s --foreground 90s /usr/bin/qemu-system-aarch64 -nodefaults -machine
> >> virt,gic-version=host,accel=kvm -cpu host -device virtio-serial-device -device
> >> virtconsole,chardev=ctd -chardev testdev,id=ctd -device pci-testdev -display none
> >> -serial stdio -kernel arm/cache.flat -smp 1 # -initrd /tmp/tmp.rUIZ3h9KLJ
> >> QEMU_ACCEL = kvm
> >> INFO: IDC-DIC: dcache clean to PoU required
> >> INFO: IDC-DIC: icache invalidation to PoU required
> >> PASS: IDC-DIC: code generation
> >> SUMMARY: 1 tests
> >>
> >> This is done intentionally in scripts/arch-run.bash::run_qemu(). I don't
> >> understand the reason for that. When I first looked at the logs, I was sure that
> >> no initrd is passed to the test. I had to go dig through the scripts to figure out
> >> that the "#" sign (which marks the beginning of a comment) is not present in the
> >> qemu invocation.
> > It's commented out because if you want to copy+paste the command line to
> > use it again it'll fail to run because the temp file will be gone. Of
> > course somebody depending on the environment for their test run will have
> > other problems when it's gone, but those people can use the
> > KVM_UNIT_TESTS_ENV variable to specify a non-temp file which includes the
> > default environment and then configure without the default environment.
> > The command line won't get the # in that case.
> 
> Hmm... wouldn't it make more sense then to generate the initrd in the logs
> directory, and keep it there? To ensure the test runs can be reproduced manually,
> if needed?

Well, there's no logs directory for standalone tests, but I do like the
idea of capturing the environment when possible. Possibly the best thing
to do is to provide an option that, when enabled, says to dump the
environment into the log before executing the test. That would be similar
to how BUILD_HEAD is output first when running the tests standalone.
Anyway, this is a good idea, but probably outside the scope of your
kvmtool work unless the initrd thing is blocking you and you need to
rework it anyway.

Thanks,
drew

> 
> Thanks,
> 
> Alex
> 
> >
> > Thanks,
> > drew
> >
> >> Thanks,
> >>
> >> Alex
> >>
> >>> There aren't currently any other ways to invoke the addition of the
> >>> -initrd command line option, because so far we only support passing a
> >>> single file to test (the environment "file"). If we ever want to pass
> >>> more files, then we'd need to create a simple file system on the initrd
> >>> and make it possible to add -initrd even when no environment is desired.
> >>> But, that may never happen.
> >>>
> >>> Thanks,
> >>> drew
> >>>
> >>>> Thanks,
> >>>>
> >>>> Alex
> >>>>
> >>>>>>  		temp_file ERRATATXT "$ERRATATXT"
> >>>>>>  		echo 'export ERRATATXT'
> >>>>>>  	fi
> >>>>>> @@ -95,12 +99,8 @@ function mkstandalone()
> >>>>>>  	echo Written $standalone.
> >>>>>>  }
> >>>>>>  
> >>>>>> -if [ "$TARGET" = "kvmtool" ]; then
> >>>>>> -	echo "Standalone tests not supported with kvmtool"
> >>>>>> -	exit 2
> >>>>>> -fi
> >>>>>> -
> >>>>>> -if [ "$ENVIRON_DEFAULT" = "yes" ] && [ "$ERRATATXT" ] && [ ! -f "$ERRATATXT" ]; then
> >>>>>> +if [ "$TARGET" != "kvmtool" ] && [ "$ENVIRON_DEFAULT" = "yes" ] && \
> >>>>>> +		[ "$ERRATATXT" ] && [ ! -f "$ERRATATXT" ]; then
> >>>>>>  	echo "$ERRATATXT not found. (ERRATATXT=$ERRATATXT)" >&2
> >>>>>>  	exit 2
> >>>>>>  fi
> >>>>>> -- 
> >>>>>> 2.32.0
> >>>>>>
> >>>>> Thanks,
> >>>>> drew 
> >>>>>
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
