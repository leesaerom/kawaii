package VO;

public class MyImage {
	private int imageSeq2;
	private String originalFileName;
	private String changedFileName;

	public MyImage() {
	}

	public MyImage(int imageSeq2, String originalFileName, String changedFileName) {
		super();
		this.imageSeq2 = imageSeq2;
		this.originalFileName = originalFileName;
		this.changedFileName = changedFileName;
	}

	public int getImageSeq() {
		return imageSeq2;
	}

	public void setImageSeq(int imageSeq2) {
		this.imageSeq2 = imageSeq2;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getChangedFileName() {
		return changedFileName;
	}

	public void setChangedFileName(String changedFileName) {
		this.changedFileName = changedFileName;
	}

	@Override
	public String toString() {
		return "MyImage [imageSeq2=" + imageSeq2 + ", originalFileName=" + originalFileName + ", changedFileName="
				+ changedFileName + "]";
	}

}
